#!/usr/bin/env bash

# Auto-installer for nvim-config-arch dependencies (Linux & macOS)

echo "Starting setup for C++ Competitive Programming Environment..."

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -x "$(command -v pacman)" ]; then
            echo "Arch Linux detected. Installing dependencies via pacman..."
            sudo pacman -S --needed gcc clang llvm make cmake
        elif [ -x "$(command -v apt-get)" ]; then
            echo "Ubuntu/Debian detected. Installing dependencies via apt..."
            sudo apt-get update
            sudo apt-get install -y gcc g++ clang llvm make cmake build-essential
        else
            echo "Unsupported Linux dist. Please install gcc, clang, llvm manually."
        fi
        
        # On Linux, clangd usually finds bits/stdc++.h natively.
        rm -f ~/.clangd
        ;;
    Darwin*)
        echo "macOS detected. Installing dependencies via Homebrew..."
        if ! [ -x "$(command -v brew)" ]; then
            echo "Error: Homebrew is not installed. Please install it first."
            exit 1
        fi
        brew install gcc llvm make cmake
        
        echo "Generating global ~/.clangd to fix macOS Apple Clang limits..."
        # Find the latest gcc version installed by brew
        GCC_PATH=$(find /opt/homebrew/opt/gcc/include/c++ -maxdepth 1 -mindepth 1 -type d | sort -r | head -n1)
        
        if [ -n "$GCC_PATH" ]; then
            cat << CLANGD_EOF > ~/.clangd
CompileFlags:
  Remove: [-stdlib=libc++]
  Add:
    - -std=c++17
    - -nostdinc++
    - -isystem
    - $GCC_PATH
    - -isystem
    - $GCC_PATH/aarch64-apple-darwin*
    - -isystem
    - $GCC_PATH/backward
CLANGD_EOF
            echo "~/.clangd created with GCC path: $GCC_PATH"
        else
            echo "GCC not found in /opt/homebrew/opt/gcc/include/c++. Please verify your GCC installation."
        fi
        ;;
    *)
        echo "Unknown OS: ${OS}"
        exit 1
        ;;
esac

echo "Setup completed successfully! Run Neovim and run :CocInstall coc-clangd if you haven't."
