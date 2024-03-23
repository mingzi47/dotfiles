return {
	{
		"rcarriga/nvim-notify",
		event = "UIEnter",
		config = function()
			vim.notify = require("notify")
			require("notify").setup({
				background_colour = "#202020",
				fps = 60,
				level = 2,
				minimum_width = 30,
				minimum_height = 15,
				render = "compact",
				stages = "slide",
				timeout = 300,
				top_down = true
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = 'UIEnter',
		opts = {
			options = {
				theme = "modus-vivendi",
				icons_enabled = true,
				component_separators = { left = "", right = "\u{e0b7}" },
				section_separators = { left = "", right = "\u{e0b6}" },
				globalstatus = true,
				refresh = {
					statusline = 100,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(content)
							return ("\u{e7c5} %s"):format(content)
						end,
					},
				},
				lualine_b = {
					{ "branch", icon = "\u{ea68}" },
				},
				lualine_c = {
					{

						'diagnostics',
						sources = { 'nvim_diagnostic' },
						sections = { 'error', 'warn', 'info', 'hint' },
						colored = true,
						update_in_insert = false,
						always_visible = false,
					}
				},
				lualine_x = {},
				lualine_y = {
					{ "encoding" },
				},
				lualine_z = {
					{
						"progress",
						fmt = function(content)
							local visual_str = {
								["v"] = true,
								["V"] = true,
								["\22"] = true,
							}
							if visual_str[tostring(vim.fn.mode())] then
								local ln_beg = vim.fn.line("v")
								local ln_end = vim.fn.line(".")
								local lines = ln_beg <= ln_end and ln_end - ln_beg + 1 or ln_beg - ln_end + 1
								return ("- %d -"):format(tostring(lines))
							end

							return ("\u{e612} %s"):format(content)
						end,
					},
				},
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	{
		'akinsho/bufferline.nvim',
		event = "UIEnter",
		version = "*",
		keys = {
			{ "[b",         "<Cmd>BufferLineCyclePrev<CR>",     desc = "Buffer : Prev [B]uffer" },
			{ "]b",         "<Cmd>BufferLineCycleNext<CR>",     desc = "Buffer : Next [B]uffer" },
			{ "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>",  desc = "Buffer : GoTo [Buffer] [1]" },
			{ "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>",  desc = "Buffer : GoTo [Buffer] [2]" },
			{ "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>",  desc = "Buffer : GoTo [Buffer] [3]" },
			{ "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>",  desc = "Buffer : GoTo [Buffer] [4]" },
			{ "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>",  desc = "Buffer : GoTo [Buffer] [5]" },
			{ "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>",  desc = "Buffer : GoTo [Buffer] [6]" },
			{ "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>",  desc = "Buffer : GoTo [Buffer] [7]" },
			{ "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>",  desc = "Buffer : GoTo [Buffer] [8]" },
			{ "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>",  desc = "Buffer : GoTo [Buffer] [9]" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- tabs
					numbers = "ordinal",
					indicator = {
						icon = '▎',
						style = 'icon',
					},
					modified_icon = '●',
					left_trunc_marker = '',
					right_trunc_marker = '',
					tab_size = 12,
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true
						}
					},
					color_icons = true,
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = true,
					show_duplicate_prefix = true,
					separator_style = "thin",
				},
			})
		end,
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
}
