local frontend = require("lsp-frontend")


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

    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })


    local map = vim.keymap.set
    -- keymap
    map('n', "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
    map('n', "<leader>af", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
    map('n', "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover Documentation" })
    map('n', "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
end

local pack = {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    config = config,
}

return pack
