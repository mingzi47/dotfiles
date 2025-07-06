

local M = {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
        { "<leader>sl", function() require("persistence").load() end,   desc = "Restore Session" },
        { 
            "<leader>ss", 
            function() 
                require("fzf-lua").register_ui_select()
                require("persistence").select() 
            end,
            desc = "Select Session" 
        },
    },
    opts = {
        dir = vim.fn.stdpath("state") .. "/sessions/",
        need = 0,
        branch = true,
    },
}


return M
