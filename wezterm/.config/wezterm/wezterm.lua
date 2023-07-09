local wezterm = require "wezterm"

-- Initial startup
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font "Fira Code",
  font_size = 16,

  color_scheme = "Breeze (Gogh)",

  window_background_opacity = 1.0,
  window_padding = {
    left = '0%',
    right = '0%',
    top = '1%',
    bottom = '0%',
  },
  window_background_image_hsb = {
    brightness = 0.8,
    hue = 1.0,
    saturation = 1.0
  },
  window_decorations = "RESIZE",
  window_close_confirmation = "NeverPrompt",
  initial_rows = 40,
  initial_cols = 130,
  tab_max_width = 20,
  hide_tab_bar_if_only_one_tab = true,
  background = {
    {
      source = {
        File = "Users/mingzi/.config/wezterm/wallpapers/0.png",
      },
      hsb = { brightness = 0.13 },
    }
  },
  leader = {
    key = 'p',
    mods = 'CMD',
    timeout_milliseconds = 3000,
  },
  keys = {
    -- Pane
    {
      key = 'v',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 's',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'x',
      mods = 'LEADER',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = 'q',
      mods = 'LEADER',
      action = wezterm.action.PaneSelect {
        alphabet = '1234567890',
      },
    },
    -- Tab
    { -- 新建窗口
      key = 'c',
      mods = 'LEADER',
      action = wezterm.action.SpawnCommandInNewTab {
        label = 'Zsh-NewWindow',
        args = { '/bin/zsh', '-l' }
      }
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = wezterm.action {
        ActivateTabRelative = -1
      }
    },
    {
      key = 'n',
      mods = 'LEADER',
      action = wezterm.action {
        ActivateTabRelative = 1
      }
    },
  }

}
