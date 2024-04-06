local config = {
	"willothy/flatten.nvim",
	opts = {
		window = {
			open = "alternate",
		},
	},
	-- Ensure that it runs first to minimize delay when opening file from terminal
	lazy = false,
	priority = 1001,
}


return config
