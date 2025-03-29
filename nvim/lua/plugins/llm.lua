local M = {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    keys = {
        { "<leader>aa", mode = "n", "<cmd>LLMSessionToggle<cr>",            desc = "AI Chat" },
        { "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>",     desc = "Generate Doc" },
        { "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>",   desc = "Code Explain" },
        { "<leader>at", mode = "v", "<cmd>LLMAppHandler WordTranslate<cr>", desc = "Quick Translate" },
        { "<leader>aT", mode = "n", "<cmd>LLMAppHandler Translate<cr>",     desc = "Ask Translate" },
        { "<leader>ac", mode = "x", "<cmd>LLMAppHandler TestCode<cr>",      desc = "Test Code" },
        { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>",     desc = "CommitMsg" },
        { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>",  desc = "OptimCompare" },
        { "<leader>aa", mode = "v", "<cmd>LLMAppHandler AttachToChat<cr>",  desc = "AttachToChat" }
    },
}

M.config = function()
    local opts = {
        keys = {
            ["Input:Submit"]      = { mode = "n", key = "<cr>" },
            ["Input:Cancel"]      = { mode = { "n", "i" }, key = "<C-c>" },
            ["Input:Resend"]      = { mode = { "n", "i" }, key = "<C-r>" },
            ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
            ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },
            ["Session:Close"]     = { mode = "n", key = { "<esc>", "q" } },
            ["Output:Ask"]        = { mode = "n", key = "i" },
            ["Output:Resend"]     = { mode = "n", key = "<C-r>" },
        },
    }

    for _, conf in ipairs({
        require("config.llm.apps"),
        require("config.llm.models").deepseek,
        require("config.llm.ui"),
    }) do
        opts = vim.tbl_deep_extend("force", opts, conf)
    end

    require("llm").setup(opts)
end

return M
