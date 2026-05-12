return {
  { "hrsh7th/nvim-cmp", enabled = false },
  { "windwp/nvim-autopairs", enabled = false },
  
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "jiangmiao/auto-pairs",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      preset = "helix"
      dofile(vim.g.base46_cache .. "whichkey")
      return { preset = "helix" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "cpp", "python" },
    },
    auto_install = true,
  },
  {
    "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    config = function()
      vim.g.UltiSnipsEditSplit = "vertical"
    end,
  },
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
