local M = {
    "folke/flash.nvim",
    evenT = "VeryLazy",
    keys = {
        { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
}

M.opts = {

}

return M
