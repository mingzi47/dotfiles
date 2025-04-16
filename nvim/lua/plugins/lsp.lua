local function config()
    vim.lsp.enable({
        "clangd",
        "gopls",
        "lua_ls",
        "ruff",
        "rust_analyzer",
        "ts_ls",
    })

    local map = vim.keymap.set
    -- keymap
    map('n', "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
    map('n', "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover Documentation" })
    map('n', "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
    map('n', "grf", function() vim.lsp.buf.format({ async = true }) end, { desc = "vim.lsp.buf.format()" })

end

local pack = {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', "BufNewFile" },
    config = config,
    cond = function()
        return true
    end,
    keys = {
    }
}

return pack
