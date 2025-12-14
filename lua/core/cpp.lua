-- C++ Competitive Programming Configuration
-- Key mappings for compiling, running, and testing C++ code

-- F8: Run test script (check.sh) - splits window and runs test
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F5>", ":vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>", { noremap = true, silent = true, buffer = true })
  end,
})

-- F9: Compile C++ file with C++17 standard and LOCAL flag
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F6>", ":w <bar> !g++ -DLOCAL -std=c++17 % -o %:r<CR>", { noremap = true, silent = true, buffer = true })
  end,
})

-- F10: Run compiled executable - splits window and runs program
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F10>", ":vsp <CR> :term ./%:r <CR>", { noremap = true, silent = true, buffer = true })
  end,
})
