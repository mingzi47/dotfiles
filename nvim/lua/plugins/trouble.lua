return {
  {
    'folke/trouble.nvim',
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>le", function() require("trouble").open("workspace_diagnostics") end, desc = "diagnostics list" },
      {
        "gr",
        function() require("trouble").open("lsp_references") end,
        desc = "lsp ref list"
      },
    },
    opts = {
      pasition = "bottom",
      height = 10,
      width = 50,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "o", "<cr>", "<2-leftmouse>" },
        open_split = { "s" },
        open_vsplit = { "v" },
        open_tab = { "<tab>" },
        jump_close = { "o" },
        toggle_mode = "m",
        switch_severity = "<c-s>",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        open_code_href = "c",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
        help = "?"
      },
    }
  },
}
