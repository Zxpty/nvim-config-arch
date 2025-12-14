-- LuaSnip configuration for custom snippets
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- Update dynamic snippets as you type
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Virtual text
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choice", "Comment" } },
      },
    },
  },
})

-- Load custom snippets
local snippets_path = vim.fn.stdpath("config") .. "/lua/snippets/"
require("luasnip.loaders.from_lua").load({ paths = snippets_path })

-- Cargar snippets de C++ directamente
local cpp_snippets = require("snippets.cpp")
luasnip.add_snippets("cpp", cpp_snippets)
luasnip.add_snippets("c", cpp_snippets) -- También para archivos .c

-- Load friendly-snippets (already installed)
require("luasnip.loaders.from_vscode").lazy_load()
