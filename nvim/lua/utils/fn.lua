local M = {}

M.feedkeys = function(keys, mode)
    local key_termcode = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(key_termcode, mode, false)
end

return M
