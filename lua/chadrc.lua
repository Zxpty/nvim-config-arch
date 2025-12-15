-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

-- Import UI configurations from organized structure
local theme_config = require "ui.theme"
local statusline_config = require "ui.statusline"
local dashboard_config = require "ui.dashboard"
local telescope_config = require "ui.telescope"

-- Theme configuration (change theme in lua/ui/theme.lua)
M.base46 = {
  theme = theme_config.theme,
  transparency = theme_config.transparency,
  hl_override = theme_config.hl_override,
}

-- Dashboard configuration (change dashboard in lua/ui/dashboard.lua)
M.nvdash = dashboard_config

-- UI configuration (change UI settings in lua/ui/ files)
M.ui = {
  telescope = { style = telescope_config.style },
  statusline = statusline_config,
  tabufline = { enabled = false }, -- Disable tabufline to fix buffer navigation errors
}

return M
