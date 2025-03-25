local wezterm = require("wezterm")
local config = wezterm.config_builder()
local platform = require("utils.platform")

-- 
if platform().is_win then
    config.default_domain = "WSL:Arch"
end

-- colorscheme
config.color_scheme = "Gruvbox Material (Gogh)"


-- font
config.font = wezterm.font("Fira Code")
config.font_size = platform().is_mac and 15 or 12

-- Appearance
-- tab
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.hide_tab_bar_if_only_one_tab = false
-- window
config.window_background_opacity = 0.90
config.macos_window_background_blur = 25
config.win32_system_backdrop = 'Tabbed'
config.window_close_confirmation = 'NeverPrompt'


-- keys
local act = wezterm.action
local leader_key = 'ALT'
config.keys = {
    {
        key = 'w',
        mods = leader_key,
        action = act.ActivateKeyTable {
            name = 'active_pane',
            timeout_milliseconds = 2000,
        }
    },
    {
        key = 'r',
        mods = leader_key,
        action = act.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
        },
    },
    {
        key = 't',
        mods = leader_key,
        action = act.ActivateKeyTable {
            name = 'active_tab',
            timeout_milliseconds = 2000,
        }
    },
    {
        key = 'Enter',
        mods = leader_key,
        action = act.ShowLauncherArgs {
            flags = "WORKSPACES|DOMAINS|LAUNCH_MENU_ITEMS",
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

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = leader_key,
        action = act.ActivateTab(i - 1)
    })
end
return config
