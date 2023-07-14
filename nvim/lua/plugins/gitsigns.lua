return {
  {
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
          end, { expr = true, desc = "Next hunk" })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Prev hunk" })

          map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage" })
          map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset" })
          map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Stage(Save)" })
          map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "Reset(Recover)" })
          map('n', '<leader>gS', gs.stage_buffer, { desc = "Stage buffer" })
          -- map('n', '<leader>gu', gs.undo_stage_hunk, {desc = ""})
          map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset buffer" })
          map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview" })
          map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Show commits" })
          map('n', '<leader>gl', gs.toggle_current_line_blame, { desc = "Show line commit" })
          map('n', '<leader>gd', gs.diffthis, { desc = "Diff file" })
          map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Diff file(all line)" })
          map('n', '<leader>gt', gs.toggle_deleted, { desc = "Show deleted" })
        end
      })
    end
  }
}
