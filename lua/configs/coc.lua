

local map = vim.keymap.set

function _G.check_back_space()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
end

map("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { expr = true, silent = true, desc = "Trigger completion" })

map("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true, silent = true, desc = "Previous completion" })

map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { expr = true, silent = true, desc = "Confirm completion" })

map("n", "[g", "<Plug>(coc-diagnostic-prev)", { desc = "Previous diagnostic" })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { desc = "Next diagnostic" })

map("n", "gd", "<Plug>(coc-definition)", { desc = "Go to definition" })
map("n", "gy", "<Plug>(coc-type-definition)", { desc = "Go to type definition" })
map("n", "gi", "<Plug>(coc-implementation)", { desc = "Go to implementation" })
map("n", "gr", "<Plug>(coc-references)", { desc = "Go to references" })

map("n", "K", ":call ShowDocumentation()<CR>", { desc = "Show documentation" })

function _G.ShowDocumentation()
  if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.fn["coc#rpc#ready"]() then
    vim.fn["CocActionAsync"]("doHover")
  else
    vim.cmd("!" .. vim.o.keywordprg .. " " .. vim.fn.expand "<cword>")
  end
end

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold",
})

map("n", "<leader>rn", "<Plug>(coc-rename)", { desc = "Rename symbol" })

map("x", "<leader>f", "<Plug>(coc-format-selected)", { desc = "Format selected" })
map("n", "<leader>f", "<Plug>(coc-format-selected)", { desc = "Format selected" })

map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { desc = "Code action" })
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { desc = "Code action" })

map("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", { desc = "Code action cursor" })
map("n", "<leader>qf", "<Plug>(coc-fix-current)", { desc = "Fix current" })

map("n", "<leader>cl", "<Plug>(coc-codelens-action)", { desc = "Code lens action" })

map("x", "if", "<Plug>(coc-funcobj-i)", { desc = "Inner function" })
map("x", "af", "<Plug>(coc-funcobj-a)", { desc = "Around function" })
map("x", "ic", "<Plug>(coc-classobj-i)", { desc = "Inner class" })
map("x", "ac", "<Plug>(coc-classobj-a)", { desc = "Around class" })

map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { expr = true, silent = true, desc = "Scroll float down" })
map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { expr = true, silent = true, desc = "Scroll float up" })
map("i", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"', { expr = true, silent = true, desc = "Scroll float down" })
map("i", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"', { expr = true, silent = true, desc = "Scroll float up" })

map("n", "<C-s>", "<Plug>(coc-range-select)", { desc = "Range select" })
map("x", "<C-s>", "<Plug>(coc-range-select)", { desc = "Range select" })

vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})



map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { desc = "Search symbols" })
map("n", "<space>j", ":<C-u>CocNext<CR>", { desc = "Next diagnostic" })
map("n", "<space>k", ":<C-u>CocPrev<CR>", { desc = "Previous diagnostic" })
map("n", "<space>p", ":<C-u>CocListResume<CR>", { desc = "Resume list" })
