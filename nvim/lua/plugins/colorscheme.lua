return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = true,
        no_bold = false,
        no_underline = false,
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('kanagawa').setup({
  --       compile = false,
  --       undercurl = true,
  --       commentStyle = { italic = false },
  --       functionStyle = {},
  --       keywordStyle = { italic = false },
  --       statementStyle = { bold = true },
  --       typeStyle = {},
  --       transparent = false,
  --       dimInactive = false,
  --       terminalColors = true,
  --       theme = "wave",
  --       background = {
  --         dark = "wave", -- wave, dragon
  --         light = "lotus"
  --       },
  --       colors = {
  --         theme = {
  --           all = {
  --             ui = {
  --               bg_gutter = "none"
  --             }
  --           }
  --         }
  --       }
  --     })
  --     vim.cmd.colorscheme "kanagawa"
  --   end
  -- },
}