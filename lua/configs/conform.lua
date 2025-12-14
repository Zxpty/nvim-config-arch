-- Formateo de código (solo para Lua, C++ y Python usan sus propios formateadores)
local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- C++ y Python: usar formateadores de CoC o manualmente
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
