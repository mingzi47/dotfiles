local wezterm = require "wezterm"
local Config = require("configs")
local platform = require("utils.platform")()

require("events.status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

if platform.is_mac then
-- Initial startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
end

return Config:init()
    :append(require("configs.window"))
    :append(require("configs.tab"))
    :append(require("configs.font"))
    :append(require("configs.keys"))
    :append(require("configs.general"))
    :append(require("configs.domains"))
    .options
