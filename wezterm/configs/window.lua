local wezterm = require("wezterm")
local colors = require("colors.custom")
local platform = require("utils.platform")()

local config = {}
config.animation_fps = 60
config.max_fps = 60
config.front_end = 'WebGpu'

config.webgpu_power_preference = 'HighPerformance'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.integrated_title_button_alignment = "Right"
config.integrated_title_button_color = "Auto"

if platform.is_win then
  config.integrated_title_button_style = "Windows"
elseif platform.is_mac or platform.is_linux then
  config.integrated_title_button_style = "MacOsNative"
end

config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
  left = 5,
  right = 10,
  top = 12,
  bottom = 7,
}
config.initial_rows = 40
config.initial_cols = 130
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
config.background = {
  {
    source = { File = wezterm.config_dir .. '/wallpapers/3.png', }
  },
  {
    source = { Color = colors.background },
    height = '100%',
    width = '100%',
    opacity = 0.90,
  }
}
config.window_frame = {
  active_titlebar_bg = '#090909',
}

return config
