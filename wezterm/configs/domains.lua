local platform = require("utils.platform")()
local config = {}

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
config.ssh_domains = {
}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
if platform.is_mac or platform.is_linux then
  config.unix_domains = {}
end

-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
if platform.is_win then
  config.wsl_domains = {
    {
      name = 'WSL:Arch',
      distribution = 'ArchLinux',
      username = 'mingzi',
      default_cwd = '/home/mingzi',
      -- default_prog = { 'fish' },
    },
  }
  -- config.default_domains = "WSL:Arch";
end


return config
