return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opt = {},
		keys = {
			{
				"gf",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		config = function()
			require('nvim-treesitter.configs').setup({
				sysc_install = true,
				auto_install = true,
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"go",
					"json",
					"javascript",
					"lua",
					"markdown",
					"markdown_inline",
					"typescript",
					"vim"
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false
				},
				indent = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = { query = "@function.outer", desc = "outer fuction" },
							["if"] = { query = "@function.inner", desc = "inner function" },
							["ac"] = { query = "@class.outer", desc = "outer class" },
							["ic"] = { query = "@class.inner", desc = "inner class" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							['@parameter.outer'] = 'v', -- charwise
							['@function.outer'] = 'V', -- linewise
							['@class.outer'] = '<c-v>', -- blockwise
						},
						include_surrounding_whitespace = false,
					},
				},
			})
		end
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		keys = {
			{ "]t",         function() require("todo-comments").jump_next() end, desc = "Todo: Next [T]odo comment" },
			{ "[t",         function() require("todo-comments").jump_prev() end, desc = "Todo: Previous [T]odo comment" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Telescope: [F]ind [T]odo" },
			{ "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc =
			"Telescope: [F]ind [T]odo/Fix/Fixme" },
		},
		config = true,
	},
}
