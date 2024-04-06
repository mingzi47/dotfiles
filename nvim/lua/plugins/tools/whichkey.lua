local config = {
	"folke/which-key.nvim",
	lazy = true,
	event = 'VeryLazy',
	config = function()
		local wk = require("which-key")

		wk.setup({
			{
				plugins = { spelling = true },
			}
		})

		wk.register({
			["<leader><tab>"] = { name = "+[Tab]" },
			["<leader>b"] = { name = "+[B]uffers" },
			["<leader>f"] = { name = "+[F]ind" },
			["<leader>g"] = { name = "+[G]it" },
			["<leader>l"] = { name = "+[L]sp" },
			["<leader>a"] = { name = "+[A]ction" },
			["<leader>p"] = { name = "+[P]ane" },
			["<leader>t"] = { name = "+[T]erm"},
		})

		wk.setup({
			window = {
				border = "double",
				position = "bottom",
				padding = { 1, 2, 1, 2 },
				zindex = 1000,
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 2, max = 50 },
				spacing = 3,
				align = "left",
			}
		})
	end
}

return config
