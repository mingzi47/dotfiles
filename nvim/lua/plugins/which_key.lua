local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        icons = {
            mappings = false,
        },
        spec = {
            { "<leader>f", group = "fzf" },
            { "<leader>a", group = "action" },
            { "<leader>b", group = "buffer" },
            { "<leader>h", group = "help" },
            { "<leader>t", group = "term" },
            { "<leader>o", group = "task" },
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

return M
