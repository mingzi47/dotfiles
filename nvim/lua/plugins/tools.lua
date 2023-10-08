return {
  {
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
        mode = { "n", "v" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffers" },
        ["<leader>f"] = { name = "+files" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>c"] = { name = "+comment" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>a"] = { name = "+Action" },
        ["<leader>p"] = { name = "+Pane" },
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
  },
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
  },
  {
    "nvim-telescope/telescope.nvim", -- npm install fd ripgrep
    lazy = true,
    keys = {
      { "<leader>ff", "<cmd> Telescope find_files<CR>", desc = "Open search file" },
      { "<leader>bf", "<cmd> Telescope buffers<CR>",    desc = "Open search buffer" },
      { "<leader>pn", "<cmd> Noice telescope <CR>",     desc = "Open search noice" },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          color_devicons = true,
          file_ignore_patterns = { "node_modules", "build", ".git" },
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.75,
            height = 0.75,
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
  },
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    keys = {
      { "<leader>t", "<cmd> ToggleTerm <cr>", desc = "open term" }
    },
    config = function()
      vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
      require("toggleterm").setup({
        size = vim.o.lines * 0.25,
        -- open_mapping = [[<esc>]],
        hide_numbers = true,
        -- 'vertical' | 'horizontal' | 'tab' | 'float'
        direction = 'horizontal',

        start_in_insert = true,
        insert_mappings = true,
        autochdir = true,
        persist_mode = false,

        close_on_exit = true,
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      })
    end
  },
}
