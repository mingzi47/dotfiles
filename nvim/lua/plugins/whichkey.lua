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
        ["s"] = { name = "surround" },
        ["ds"] = { name = "surround" },
        ["cs"] = { name = "surround" },
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
  }
}