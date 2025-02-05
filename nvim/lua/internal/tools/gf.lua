local M = {}

M.opts = {
    url_pattern = '[a-zA-z]+://[^\\s]*'
}

function M.gf()
    local cfile = vim.fn.expand('<cfile>')

    local url_match = cfile:match(M.opts.url_pattern)

    if url_match then
        vim.ui.open(url_match)
    else
        vim.cmd("normal! gf")
    end
end

return M
