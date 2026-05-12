-- Theme Configuration
-- Change your theme here! Available themes: https://github.com/NvChad/base46/tree/v2.5/lua/base46/themes
-- Popular themes: nord, catppuccin, tokyonight, dracula, gruvbox, onedark, etc.

return {
  theme = "gruvbox_light", -- Change this to your preferred theme
  transparency = false, -- En modo claro, mejor desactivar la transparencia
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}
