local api = vim.api

local function get_gpp_command()
  local os_name = vim.loop.os_uname().sysname
  if os_name == "Darwin" then
    local handle = io.popen("ls /opt/homebrew/bin/g++-* 2>/dev/null | sort -V | tail -n 1")
    if handle then
      local result = handle:read("*a")
      handle:close()
      result = result:gsub("\n", "")
      if result ~= "" then return result end
    end
  end
  return "g++"
end

local GPP_CMD = get_gpp_command()

local runners = {
  cpp = {
    compile = string.format(":w <bar> !%s -DLOCAL -std=c++17 %% -o %%:r<CR>", GPP_CMD),
    run = ":vsp <CR> :term ./%:r <CR>",
    test = ":vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>",
  },
  c = {
    compile = ":w <bar> !gcc -DLOCAL %% -o %%:r<CR>",
    run = ":vsp <CR> :term ./%:r <CR>",
    test = ":vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>",
  },
  python = {
    run = ":w <bar> :vsp <CR> :term python3 % <CR>",
    test = ":vsp <CR> :term check.sh %:r %:h/in %:h/out <CR>",
  }
}

api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(runners),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local runner = runners[ft]

    if not runner then return end

    if runner.compile then
      vim.keymap.set("n", "<F1>", runner.compile, { desc = "Compile code", noremap = true, silent = true, buffer = args.buf })
    end

    if runner.run then
      local run_key = ft == "python" and "<F9>" or "<F2>"
      vim.keymap.set("n", run_key, runner.run, { desc = "Run code", noremap = true, silent = true, buffer = args.buf })
    end

    if runner.test then
      vim.keymap.set("n", "<F8>", runner.test, { desc = "Run tests", noremap = true, silent = true, buffer = args.buf })
    end
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})
