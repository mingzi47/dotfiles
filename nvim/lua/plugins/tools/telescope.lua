local config = {
	"nvim-telescope/telescope.nvim", -- npm install fd ripgrep
	lazy = true,
	keys = {
		{ "<leader>ff", "<cmd> Telescope find_files<CR>", desc = "Telescope: [F]ind [F]ile" },
		{ "<leader>fb", "<cmd> Telescope buffers<CR>",    desc = "Telescope: [F]ind [B]uffer" },
		{ "<leader>fw", "<cmd> Telescope live_grep<CR>",  desc = "Telescope: [F]ind [W]ord" },
		{ "<leader>fg", "<cmd> Telescope git_status<CR>", desc = "Telescope: [F]ind [G]it_status" },
		-- { "<leader>fn", "<cmd> Noice telescope <CR>",     desc = "Telescope: [F]ind [N]oice" },
	},
	config = function()
		require('telescope').setup({
			defaults = {
				color_devicons = true,
				file_ignore_patterns = { "node_modules", "build", ".git", ".vscode", "bin" },
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.75,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.95,
					height = 0.95,
					preview_cutoff = 120,
				},
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				mappings = {
					n = {
						["q"] = require("telescope.actions").close,
						["d"] = require("telescope.actions").delete_buffer,
						["s"] = require("telescope.actions").file_split,
						["v"] = require("telescope.actions").file_vsplit,
					},
				},
			},
		})
	end,
	dependencies =
	{ "nvim-lua/plenary.nvim" }
}


return config
