return {
  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- s + [select] + [pair]
          normal = "s",
          -- S + [pair]
          normal_cur = "S",
          -- [visual] + s + [pair]
          visual = "s",
          visual_line = "S",
          -- ds + [pair]
          delete = "ds",
          -- cs + [old pair] [new pair]
          change = "cs"
        }
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    keys = {
      { "<leader>cl", desc = "Comment toggle current line",  mode = { "v", "n" } },
      { "<leader>cb", desc = "Comment toggle current block", mode = { "v", "n" } },
    },
    config = function()
      require('Comment').setup({
        toggler = {
          line = '<leader>cl',
          block = '<leader>cb',
        },
        opleader = {
          line = '<leader>cl',
          block = '<leader>cb',
        }
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({ map_cr = true })
    end,
  },
  {
    "nvim-telescope/telescope.nvim", -- npm install fd ripgrep
    lazy = true,
    keys = {
      { "<leader>ff", "<cmd> Telescope find_files<CR>", desc = "Open search file" },
      { "<leader>bf", "<cmd> Telescope buffers<CR>",    desc = "Open search buffer" },
      { "<leader>at", "<cmd> TodoTelescope <CR>",       desc = "TodoLists" }
    },
    config = function()
      require('telescope').setup({
        defaults = {
          color_devicons = true,
          file_ignore_patterns = { "node_modules", "build", ".git" },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          multi_icon = " ",
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
            width = 0.87,
            height = 0.80,
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
}
