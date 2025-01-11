local pack = {
    "folke/noice.nvim",
    event = "UIEnter",
    dependencies = {
        {
            "rcarriga/nvim-notify",
            opts = {
                timeout = 700,
                render = "minimal",
                stages = "static",
                max_width = 30,
            }
        }
    }
}

pack.opts = {
    cmdline = {
        view = "cmdline",
    },
    lsp = {
        progress = {
            enabled = false,
        }
    },
}

pack.keys = {
    { "<leader>fn", "<cmd>Noice fzf<cr>", desc = "Noice history" }
}

return pack
