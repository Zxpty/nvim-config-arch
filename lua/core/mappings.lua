require "nvchad.mappings"

local map = vim.keymap.set

vim.schedule(function()
  pcall(function() vim.keymap.del("n", "<Tab>") end)
  pcall(function() vim.keymap.del("n", "<S-Tab>") end)
end)

map("n", ";", ":", { desc = "CMD mode" })
map("i", "jk", "<ESC>")

vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")
map({ "n", "t" }, "<A-v>", "<nop>", { desc = "disabled" })
map({ "n", "t" }, "<A-h>", "<nop>", { desc = "disabled" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("i", "<A-h>", "<Left>")
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-l>", "<Right>")

map("n", "<C-a>", "ggVG")
map("i", "<C-a>", "<ESC>ggVG")
map("v", "<C-a>", "<ESC>ggVG")

map("n", "<leader>lg", "<cmd>LazyGit<CR>")

map("v", "<leader>i{", "vi{")
map("v", "<leader>a{", "va{")
map("v", "<leader>i(", "vi(")
map("v", "<leader>a(", "va(")
map("v", "<leader>i[", "vi[")
map("v", "<leader>a[", "va[")
map("v", '<leader>i"', 'vi"')
map("v", '<leader>a"', 'va"')
map("v", "<leader>i'", "vi'")
map("v", "<leader>a'", "va'")
map("v", "<leader>i`", "vi`")
map("v", "<leader>a`", "va`")

for i = 1, 9 do
  map("n", "g" .. i, function()
    local bufs = vim.fn.getbufinfo { buflisted = 1 }
    if bufs[i] then vim.api.nvim_set_current_buf(bufs[i].bufnr) end
  end)
end

map("n", "g0", function()
  local bufs = vim.fn.getbufinfo { buflisted = 1 }
  if bufs[#bufs] then vim.api.nvim_set_current_buf(bufs[#bufs].bufnr) end
end)

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle {
    pos = "float",
    id = "floatTerm",
    float_opts = { row = 0.1, col = 0.08, width = 0.8, height = 0.7, border = "rounded" },
  }
end)

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>")

map("n", "<leader>cd", function()
  print("=== Diagnostico CoC ===\n")
  local coc_ok = vim.fn.exists("*coc#rpc#ready") == 1
  local clangd_ok = vim.fn.executable("clangd") == 1
  print("CoC: " .. (coc_ok and "✓" or "✗") .. " | Clangd: " .. (clangd_ok and "✓" or "✗"))
end, { desc = "Diagnosticar autocompletado" })
