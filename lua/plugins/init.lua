return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- LSP config (solo para Lua, C++ y Python los maneja CoC)
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Lazygit integration in Neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() end,
  },

  -- Neovim Tmux Navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      preset = "helix", dofile(vim.g.base46_cache .. "whichkey")
      return {
        preset = "helix",
      }
    end,
  },


  -- Treesitter: Solo parsers necesarios para competitive programming
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "cpp", -- C++
        "python", -- Python
      },
    },
    auto_install = true,
  },

  -- UltiSnips for CoC snippets
  {
    "SirVer/ultisnips",
    dependencies = {
      "honza/vim-snippets",
    },
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
      vim.g.UltiSnipsEditSplit = "vertical"
    end,
  },

  -- CoC.nvim: Autocompletado para C++ y Python
  {
    "neoclide/coc.nvim",
    branch = "release",
    build = "yarn install --frozen-lockfile",
    event = "VeryLazy",
    config = function()
      require "configs.coc"
    end,
  },
}
