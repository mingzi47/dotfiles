local pack = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    opts = {
        preset = "helix",
        spec = {
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>e", group = "File Explorer" },
            { "<leader>t", group = "Term" },
            { "s", group = "Surround" },
            { "<leader>q", "<cmd>qa<cr>", desc = "Quit" },
        }
    },
}


return pack
