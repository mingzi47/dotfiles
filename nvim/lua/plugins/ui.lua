return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = 'VeryLazy',
    opts = {
      options = {
        theme = "auto",
        icons_enabled = true,
        -- component_separators = { left = "\u{e0b5}", right = "\u{e0b7}" },
        component_separators = { left = "", right = "\u{e0b7}" },
        section_separators = { left = "", right = "\u{e0b6}" },
        -- section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
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
            colors = {
              error = "#BF616A",
              warn = "#EBCB8B",
              info = "#A3BE8C",
              hint = "#88C0D0",
            },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          }
        },
        lualine_x = {},
        lualine_y = {
          { "filetype" },
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
    "rcarriga/nvim-notify",
    event = "VeryLazy",
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
}
