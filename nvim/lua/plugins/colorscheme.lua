return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "",  -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        },
        config = function ()
            vim.cmd.colorscheme "gruvbox"
        end,
    }
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "frappe", -- latte, frappe, macchiato, mocha
    --             background = {
    --                 light = "latte",
    --                 dark = "mocha",
    --             },
    --             transparent_background = true,
    --             show_end_of_buffer = false,
    --             term_colors = false,
    --             dim_inactive = {
    --                 enabled = false,
    --                 shade = "dark",
    --                 percentage = 0.15,
    --             },
    --             no_italic = true,
    --             no_bold = false,
    --             no_underline = false,
    --         })
    --         vim.cmd.colorscheme "catppuccin"
    --     end
    -- },
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
