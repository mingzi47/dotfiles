local M = {
    "nvim-telescope/telescope.nvim", -- npm install fd ripgrep
	lazy = true,
    keys = {
		{ "<leader>sf", "<cmd> Telescope find_files<CR>", desc = "[S]earch [F]ile" },
		{ "<leader>sb", "<cmd> Telescope buffers<CR>",    desc = "[S]earch [B]uffer" },
		{ "<leader>sw", "<cmd> Telescope live_grep<CR>",  desc = "[S]earch [W]ord" },
		{ "<leader>ss", "<cmd> Telescope lsp_document_symbols<CR>", desc = "[S]eaarch LSP [S]ymbols" },
	},
    dependencies = { "nvim-lua/plenary.nvim" }
}

M.config = function ()
    require('telescope').setup({
       defaults = {
            color_devicons = true,
            file_ignore_patterns = { "node_modules", "build", ".git", ".vscode", "bin" },
            initial_mode = "normal",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            -- layout_strategy = "horizontal",
            path_display = { "smart" },
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.75,
                    preview_cutoff = 120,
                },
                vertical = {
                    mirror = false,
                },
                width = {padding = 0},
                height = {padding = 0},
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
        pickers = {
            find_files = {
                initial_mode = "insert",
                layout_config = {
                    preview_width = 0,
                    width = 0.4,
                    height = 0.3,
                },
            },
            buffers = {
                initial_mode = "insert",
                layout_config = {
                    preview_width = 0,
                    width = 0.4,
                    height = 0.3,
                },
            },
            live_grep = {
                initial_mode = 'insert',
            }
        }
    })
end


return M
