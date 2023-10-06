return {
  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- s + [select] + [pair]
          normal = "ys",
          -- S + [pair]
          normal_cur = "yS",
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opt = {},
    keys = {
      {
        "f",
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
        ensure_installed = 'all',
        sysc_install = true,
        auto_install = true,
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
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
          },
        },
      })
    end
  }
}
