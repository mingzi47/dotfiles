local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font "Fira Code"
config.font_size = 16
config.colors = require("colors.custom")

return config
