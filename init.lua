if vim.g.vscode then
  vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }
  vim.keymap.set("n", "Y", '"+y', { noremap = true, silent = true })
  vim.keymap.set("v", "Y", '"+y', { noremap = true, silent = true })
  vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })
  vim.keymap.set("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true })
  return
end

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
}

require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

pcall(dofile, vim.g.base46_cache .. "defaults")
pcall(dofile, vim.g.base46_cache .. "statusline")

require "core.options"
require "core.autocmds"
require "core.runners"

vim.schedule(function()
  require "core.mappings"
end)
