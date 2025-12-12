-- Load NvChad's default LSP config (includes `on_attach` and `capabilities`)
local default_config = require "nvchad.configs.lspconfig"
local on_attach = default_config.on_attach
local capabilities = default_config.capabilities

-- Custom on_attach to add extra keymaps for all LSPs
local function custom_on_attach(client, bufnr)
  -- Load NvChad's default on_attach
  on_attach(client, bufnr)

  -- Extra keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

-- HTML LSP
vim.lsp.config("html", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- CSS LSP
vim.lsp.config("cssls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TailwindCSS LSP
vim.lsp.config("tailwindcss", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Bash LSP
vim.lsp.config("bashls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "sh", "bash" },
})

-- Markdown LSP (Marksman)
vim.lsp.config("marksman", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "markdown", "markdown.mdx" },
})

-- TypeScript/JavaScript
vim.lsp.config("ts_ls", {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false -- disable formatting to avoid conflict with prettier
    vim.diagnostic.config({ virtual_text = true }, bufnr)

    -- Still reuse our extra keymaps
    custom_on_attach(client, bufnr)
  end,
  capabilities = capabilities,

  cmd = { "typescript-language-server", "--stdio" },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },

  settings = {
    typescript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
    javascript = {
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertText = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
})

-- JSON LSP
vim.lsp.config("jsonls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Emmet LSP
vim.lsp.config("emmet_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescriptreact",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
})

-- Lua LSP
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      runtime = {
        version = "LuaJIT",
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- C++ LSP (clangd) for competitive programming
vim.lsp.config("clangd", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    fallbackFlags = { "-std=c++17" },
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})

-- Use Telescope UI dropdown for vim.ui.select prompts
vim.ui.select = require("telescope.themes").get_dropdown {}
require("telescope").load_extension "ui-select"


-- -- Python LSP
-- lspconfig.pyright.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
