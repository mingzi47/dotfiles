local frontend = require("config.lsp-frontend")

local function config()
    local on_attach = function(client, _)
        vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
        client.server_capabilities.semanticTokensProvider = nil
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    for server, conf in pairs(frontend) do
        require('lspconfig')[server].setup(vim.tbl_deep_extend('force', {
            on_attach = on_attach,
            capabilities = capabilities,
        }, conf))
    end

    vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
        local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
        local bufnr = vim.api.nvim_get_current_buf()
        vim.diagnostic.reset(ns, bufnr)
        return true
    end

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
