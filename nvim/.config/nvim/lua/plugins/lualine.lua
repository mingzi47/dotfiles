return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('lualine').setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          refresh = {
            statusline = 100,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(content, context)
                return (" %s"):format(content)
              end,
            },
          },
          lualine_b = {
            { "branch", icon = "" },
            -- { "filetype" }
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
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            }
          },
          lualine_x = {
          },
          lualine_y = {
            {
              "space_style",
              fmt = function(content, context)
                ---@diagnostic disable-next-line: param-type-mismatch
                local expand = vim.opt_local.expandtab:get()
                ---@diagnostic disable-next-line: param-type-mismatch
                local widht = vim.opt_local.shiftwidth:get()
                local style = expand and "Spaces" or "Tab Size"
                return ("%s: %s"):format(style, widht)
              end,
            },
            "encoding",
          },
          lualine_z = {
            {
              "progress",
              fmt = function(content, context)
                local visual_str = {
                  ["v"] = true,
                  ["V"] = true,
                  ["\22"] = true,
                }
                if visual_str[tostring(vim.fn.mode())] then
                  local ln_beg = vim.fn.line("v")
                  local ln_end = vim.fn.line(".")
                  -- local end = vim.fn.line("")
                  local lines = ln_beg <= ln_end and ln_end - ln_beg + 1 or ln_beg - ln_end + 1
                  return ("- %d -"):format(tostring(lines))
                end

                return ("  %s"):format(content)
              end,
            },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
}
