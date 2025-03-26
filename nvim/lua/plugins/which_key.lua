local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        icons = {
            mappings = false,
        },
        spec = {
            { "<leader>f", mode = "n",          group = "fzf" },
            { "<leader>a", mode = { "n", "x" }, group = "ai" },
            { "<leader>s", mode = "n",          group = "session" },
            { "<leader>b", mode = "n",          group = "buffer" },
            { "<leader>h", mode = "n",          group = "help" },
            { "<leader>t", mode = { "n", "x" }, group = "term" },
            { "<leader>o", mode = "n",          group = "task" },
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
