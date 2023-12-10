local wezterm = require("wezterm")
local platform = require("utils.platform")()
local config = {}

config.font = wezterm.font "Fira Code"

if platform.is_mac then
  config.font_size = 15
elseif platform.is_linux then
  config.font_size = 13
elseif platform.is_win then
  config.font_size = 13
end

config.color_scheme = 'Gruvbox dark, soft (base16)'
-- config.color_scheme = 'GitHub Dark'

return config
