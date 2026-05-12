#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODE="all"
DRY_RUN=0
SYNC_COC=1

usage() {
    cat <<'EOF'
Usage: ./install.sh [options]

Options:
    --all           Install dependencies and configure clangd (default).
    --deps          Install system dependencies only.
    --clangd        Configure clangd only.
    --no-sync-coc   Do not update coc-settings.json.
    --dry-run       Print commands without running them.
    -h, --help      Show this help text.
EOF
}

log() {
    printf '%s\n' "$*"
}

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

run() {
    if [[ "$DRY_RUN" -eq 1 ]]; then
        printf '+'
        printf ' %q' "$@"
        printf '\n'
    else
        "$@"
    fi
}

require_command() {
    command -v "$1" >/dev/null 2>&1
}

detect_os() {
    case "$(uname -s)" in
        Linux*) printf '%s\n' "linux" ;;
        Darwin*) printf '%s\n' "macos" ;;
        *) printf '%s\n' "unknown" ;;
    esac
}

detect_pkg_manager() {
    if require_command pacman; then
        printf '%s\n' "pacman"
    elif require_command apt-get; then
        printf '%s\n' "apt"
    elif require_command brew; then
        printf '%s\n' "brew"
    else
        printf '%s\n' "none"
    fi
}

install_linux_deps() {
    local pkg_manager="$1"

    case "$pkg_manager" in
        pacman)
            run sudo pacman -S --needed --noconfirm gcc clang llvm make cmake
            ;;
        apt)
            run sudo apt-get update
            run sudo apt-get install -y gcc g++ clang llvm clangd make cmake build-essential
            ;;
        *)
            die "No supported Linux package manager found."
            ;;
    esac
}

install_macos_deps() {
    if ! require_command brew; then
        die "Homebrew is not installed."
    fi

    run brew update
    run brew install gcc llvm make cmake
}

resolve_clangd_bin() {
    if require_command clangd; then
        command -v clangd
        return 0
    fi

    if [[ "$OS" == "macos" ]] && require_command brew; then
        local llvm_prefix
        llvm_prefix="$(brew --prefix llvm 2>/dev/null || true)"
        if [[ -n "$llvm_prefix" && -x "$llvm_prefix/bin/clangd" ]]; then
            printf '%s\n' "$llvm_prefix/bin/clangd"
            return 0
        fi
    fi

    return 1
}

sync_coc_settings() {
    local clangd_bin="$1"
    local coc_file="$SCRIPT_DIR/coc-settings.json"

    [[ -f "$coc_file" ]] || return 0
    [[ -n "$clangd_bin" ]] || return 0

    if grep -q '"clangd.path"' "$coc_file"; then
        sed -i.bak "s|^  \"clangd.path\": .*|  \"clangd.path\": \"$clangd_bin\"|" "$coc_file"
        rm -f "$coc_file.bak"
    fi
}

configure_linux() {
    local pkg_manager="$1"

    install_linux_deps "$pkg_manager"
    configure_linux_clangd
}

configure_linux_clangd() {
    log "Linux detected: removing any macOS-specific ~/.clangd override."
    rm -f "$HOME/.clangd" 2>/dev/null || true

    if [[ "$SYNC_COC" -eq 1 ]]; then
        local clangd_bin
        clangd_bin="$(resolve_clangd_bin || true)"
        if [[ -n "$clangd_bin" ]]; then
            sync_coc_settings "$clangd_bin"
            log "Updated coc-settings.json to use: $clangd_bin"
        else
            log "clangd was not found in PATH after installation."
        fi
    fi
}

configure_macos() {
    install_macos_deps
    configure_macos_clangd
}

configure_macos_clangd() {
    local gcc_prefix gcc_include clangd_bin

    gcc_prefix=""
    if require_command brew; then
        gcc_prefix="$(brew --prefix gcc 2>/dev/null || true)"
    fi

    if [[ -n "$gcc_prefix" ]]; then
        gcc_include="$(find "$gcc_prefix/include/c++" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort -r | head -n1 || true)"
        if [[ -n "$gcc_include" ]]; then
            cat > "$HOME/.clangd" <<EOF
CompileFlags:
    Remove: [-stdlib=libc++]
    Add:
        - -std=c++17
        - -nostdinc++
        - -isystem
        - $gcc_include
        - -isystem
        - $gcc_include/$(uname -m)-apple-darwin*
        - -isystem
        - $gcc_include/backward
EOF
            log "Wrote ~/.clangd using GCC headers at: $gcc_include"
        fi
    fi

    if [[ "$SYNC_COC" -eq 1 ]]; then
        clangd_bin="$(resolve_clangd_bin || true)"
        if [[ -n "$clangd_bin" ]]; then
            sync_coc_settings "$clangd_bin"
            log "Updated coc-settings.json to use: $clangd_bin"
        else
            log "clangd was not found yet. You may need to add Homebrew's llvm bin directory to PATH."
        fi
    fi
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)
                MODE="all"
                ;;
            --deps)
                MODE="deps"
                ;;
            --clangd)
                MODE="clangd"
                ;;
            --no-sync-coc)
                SYNC_COC=0
                ;;
            --dry-run)
                DRY_RUN=1
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                die "Unknown option: $1"
                ;;
        esac
        shift
    done
}

main() {
    OS="$(detect_os)"
    PKG_MANAGER="$(detect_pkg_manager)"

    case "$MODE" in
        all)
            case "$OS" in
                linux)
                    log "Linux detected."
                    configure_linux "$PKG_MANAGER"
                    ;;
                macos)
                    log "macOS detected."
                    configure_macos
                    ;;
                *)
                    die "Unsupported OS: $(uname -s)"
                    ;;
            esac
            ;;
        deps)
            case "$OS" in
                linux)
                    log "Linux detected."
                    install_linux_deps "$PKG_MANAGER"
                    ;;
                macos)
                    log "macOS detected."
                    install_macos_deps
                    ;;
                *)
                    die "Unsupported OS: $(uname -s)"
                    ;;
            esac
            ;;
        clangd)
            case "$OS" in
                linux)
                    log "Linux detected."
                    configure_linux_clangd
                    ;;
                macos)
                    log "macOS detected."
                    configure_macos_clangd
                    ;;
                *)
                    die "Unsupported OS: $(uname -s)"
                    ;;
            esac
            ;;
    esac

    log "Setup completed successfully."
    log "If CoC is used here, run :CocInstall coc-clangd once Neovim is open."
}

parse_args "$@"
main
