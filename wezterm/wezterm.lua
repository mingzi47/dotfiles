local wezterm = require "wezterm"
local Config = require("configs")


wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return Config:init()
    :append(require("configs.window"))
    :append(require("configs.tab"))
    :append(require("configs.font"))
    :append(require("configs.keys"))
    :append(require("configs.general"))
    :append(require("configs.domains"))
    :append(require("configs.launch"))
    .options
