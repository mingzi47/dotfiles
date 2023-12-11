local platform = require("utils.platform")()
local config = {}

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
config.ssh_domains = {
}


-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
if platform.is_win then
  config.default_domain = "WSL:Arch";
end


return config
