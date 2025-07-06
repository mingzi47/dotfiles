local utils = require("llm-cfg.utils")

local M = {}

M.ollama = {
    url = "http://localhost:11434/api/chat",
    model = "deepseek-coder",
    api_type = "ollama",
    streaming_handler = utils.local_llm_streaming_handler,
    parse_handler = utils.local_llm_parse_handler,
}

M.deepseek = {
    url = "https://api.deepseek.com/chat/completions",
    model = "deepseek-chat",
    api_type = "openai",
    max_tokens = 8000,
    fetch_key = function()
        return vim.env.DEEPSEEK_KEY
    end,
}

return M
