local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- colorscheme
config.color_scheme = "Gruvbox Material (Gogh)"

-- font
config.font = wezterm.font("Fira Code")
config.font_size = 15

-- Appearance
-- tab
config.hide_tab_bar_if_only_one_tab = true
-- window
config.window_background_opacity = 0.90
config.macos_window_background_blur = 25


-- keys
local act = wezterm.action
config.keys = {
    {
        key = 'w',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'active_pane',
            timeout_milliseconds = 2000,
        }
    },
    {
        key = 'r',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
        },
    },
    {
        key = 't',
        mods = 'ALT',
        action = act.ActivateKeyTable {
            name = 'active_tab',
            timeout_milliseconds = 2000,
        }
    }
}

config.key_tables = {
    active_pane = {
        { key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left' },
        { key = 'h',          action = act.ActivatePaneDirection 'Left' },

        { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
        { key = 'l',          action = act.ActivatePaneDirection 'Right' },

        { key = 'UpArrow',    action = act.ActivatePaneDirection 'Up' },
        { key = 'k',          action = act.ActivatePaneDirection 'Up' },

        { key = 'DownArrow',  action = act.ActivatePaneDirection 'Down' },
        { key = 'j',          action = act.ActivatePaneDirection 'Down' },
        { key = 'v',          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 's',          action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'q',          action = act.CloseCurrentPane { confirm = false }, }

    },

    resize_pane = {
        { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'h',          action = act.AdjustPaneSize { 'Left', 1 } },

        { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'l',          action = act.AdjustPaneSize { 'Right', 1 } },

        { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'k',          action = act.AdjustPaneSize { 'Up', 1 } },

        { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'j',          action = act.AdjustPaneSize { 'Down', 1 } },

        { key = 'Escape',     action = 'PopKeyTable' },
    },

    active_tab = {
        { key = 'c', action = act.SpawnTab 'CurrentPaneDomain', }
    },
}
return config
