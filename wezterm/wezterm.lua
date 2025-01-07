local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.show_new_tab_button_in_tab_bar = false

if string.find(wezterm.target_triple, "windows") then
  config.default_domain = "WSL:Arch"
end

--Colors & Appearance
config.color_scheme = 'Gruvbox Material (Gogh)'
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

config.window_padding = {
  left = 10,
  right = 0,
  top = 5,
  bottom = 0,
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

config.window_background_opacity = 0.92
config.text_background_opacity = 1

-- config.background = {
-- 	{
-- 		source = { File = wezterm.config_dir .. '/wallpapers/2.png', },
-- 	}
-- }

-- Fonts
local font_scale = 1.0
if string.find(wezterm.target_triple, "darwin") then
	font_scale = 1.15
end

config.font = wezterm.font_with_fallback({
  {
    family = "Fira Code",
    scale = font_scale,
    weight = "Medium",
    -- italic = true,
    -- => != !==
    -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
})


-- event: gui-startup
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  -- window:gui_window():set_inner_size(1000, 600)
  -- window:gui_window():set_position(100, 100)
  window:gui_window():maximize()
end)

-- event: update-status
config.status_update_interval = 1000
wezterm.on("update-status", function(window)
  local date = wezterm.strftime '%b %-d %H:%M '

  -- local bat_str = ''

  -- for _, bat in ipairs(wezterm.battery_info()) do
  --   bat_str = bat_str .. string.format('%.0f%%', bat.state_of_charge * 100)
  -- end

  window:set_right_status(wezterm.format({
    { Text = ' ' },
    { Foreground = { Color = '#74c7ec' } },
    -- { Background = { Color = 'rgba(0,0,0,0)' } },
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.nerdfonts.fa_calendar .. ' ' .. date },
    { Text = ' ' },
  }))
end)

-- event: format-tab-title
wezterm.on('format-tab-title', function (tab, _, _, _, _)
    -- i do not like how i can basically hide tabs if i zoom in
    local is_zoomed = ''
    if tab.active_pane.is_zoomed then
        is_zoomed = 'z'
    end

    return {
        { Text = ' ' .. tab.tab_index + 1 .. is_zoomed .. ' ' },
    }
end)

local act = wezterm.action

-- Mouse Bingding
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}


-- Key Bingding
config.leader = {
  key = 'w',
  mods = 'ALT',
  timeout_milliseconds = 3000,
}
config.keys = {
  -- menu
  {
    key = 'm',
    mods = 'LEADER',
    action = act.ShowLauncher, 
  },
  -- Pane
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = act.PaneSelect {
      alphabet = '1234567890',
    },
  },
  { 
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Up')
  },
  { 
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection('Down')
  },
  {
     key = 'h',
     mods = 'LEADER',
     action = act.ActivatePaneDirection('Left')
   },
  {
     key = 'l',
     mods = 'LEADER',
     action = act.ActivatePaneDirection('Right')
   },
  -- Tab
  { -- 新建窗口
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      label = 'Zsh-NewWindow',
      args = { '/bin/zsh', '-l' }
    }
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1)
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = act.ActivateTabRelative(1)
  },
}

return config
