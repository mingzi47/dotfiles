local wezterm = require("wezterm")
local platform = require("utils.platform")()

local config = {}
config.animation_fps = 60
config.max_fps = 60
config.front_end = 'WebGpu'

config.webgpu_power_preference = 'HighPerformance'
config.window_decorations = "RESIZE"


config.window_background_opacity = 0.90
if platform.is_win then
	config.win32_system_backdrop = 'Acrylic'
elseif platform.is_mac or platform.is_linux then
	config.macos_window_background_blur = 20
end

config.hide_tab_bar_if_only_one_tab = true
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
		source = { File = wezterm.config_dir .. '/wallpapers/2.png', },
	}
}

return config
