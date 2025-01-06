local pack = {
    "folke/noice.nvim",
    event = "UIEnter",
    dependencies = {
        -- "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                timeout = 300,
                render = "minimal",
                stages = "slide",
            }
        }
    }
}

pack.opts = {
    cmdline = {
        view = "cmdline",
    }
}

pack.keys = {
    { "<leader>fn", "<cmd>Noice fzf<cr>", desc = "Noice history" }
}

return pack
