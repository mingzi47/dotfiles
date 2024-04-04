local servers = {}

-- lua
servers["lua_ls"] = {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},

		hint = {
			enable = true,
			arrayIndex = 'Enable',
			setType = true,
		},
	},
}


-- cpp
servers["clangd"] = {}


-- gopls
servers["gopls"] = {}


-- rust
servers["rust_analyzer"] = {}

return servers
