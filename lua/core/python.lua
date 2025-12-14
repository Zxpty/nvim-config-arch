-- Python Competitive Programming Configuration
-- Key mappings for compiling, running, and testing Python code

-- F8: Run test script (check.sh) - splits window and runs test
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<F8>", ":vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>", { noremap = true, silent = true, buffer = true })
  end,
})

-- F9: Run Python file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<F9>", ":w <bar> :vsp <CR> :term python3 % <CR>", { noremap = true, silent = true, buffer = true })
  end,
})
