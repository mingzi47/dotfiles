local config = {
	'lewis6991/gitsigns.nvim',
	lazy = true,
	event = 'VeryLazy',
	config = function()
		require('gitsigns').setup({
			signs = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '➤' },
				topdelete = { text = '➤' },
				changedelete = { text = '▎' },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				-- Navigation
				map('n', ']g', function()
					if vim.wo.diff then return ']g' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, desc = "Git: Next [G]it hunk" })

				map('n', '[g', function()
					if vim.wo.diff then return '[g' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true, desc = "Git: Prev [G]it hunk" })

				map('n', '<leader>gs', gs.stage_hunk, { desc = "Git: [G]it [S]tage" })
				map('n', '<leader>gr', gs.reset_hunk, { desc = "Git: [G]it [R]eset" })
				map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
					{ desc = "Git: [G]it [S]tage(Save)" })
				map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
					{ desc = "Git: [G]it [R]eset(Recover)" })
				map('n', '<leader>gS', gs.stage_buffer, { desc = "Git: [G]it [S]tage buffer" })
				-- map('n', '<leader>gu', gs.undo_stage_hunk, {desc = ""})
				map('n', '<leader>gR', gs.reset_buffer, { desc = "Git: [G]it [R]eset buffer" })
				map('n', '<leader>gp', gs.preview_hunk, { desc = "Git: [G]it [P]review" })
				map('n', '<leader>gb', function() gs.blame_line { full = true } end,
					{ desc = "Git: [G]it [B]lame commits" })
				map('n', '<leader>gl', gs.toggle_current_line_blame, { desc = "Git: [G]it [L]ine commit" })
				map('n', '<leader>gd', gs.diffthis, { desc = "Git: [G]it [D]iff file" })
				map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Git: [G]it [D]iff file(all line)" })
				map('n', '<leader>gt', gs.toggle_deleted, { desc = "Git: [G]it Show deleted" })
			end
		})
	end
}

return config
