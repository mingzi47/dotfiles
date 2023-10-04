local wezterm = require("wezterm")

local config = {}

config.leader = {
  key = 'p',
  mods = 'CTRL',
  timeout_milliseconds = 3000,
}
config.keys = {
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

return config
