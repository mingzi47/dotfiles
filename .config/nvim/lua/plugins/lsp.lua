local M = {
    'neovim/nvim-lspconfig',
    event = { 'VeryLazy' },
    config = function()
        vim.lsp.enable({
            "clangd",
            "gopls",
            "lua_ls",
            "ruff",
            "rust_analyzer",
            "ts_ls",
        })

        vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
            local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
            local bufnr = vim.api.nvim_get_current_buf()
            vim.diagnostic.reset(ns, bufnr)
            return true
        end


        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                -- keymap
                vim.keymap.del('n', 'K', { buffer = args.buf })

                local opts = function(desc)
                    return {
                        desc = desc,
                        buffer = args.buf
                    }
                end

                local map = vim.keymap.set
                map('n', "gd", vim.lsp.buf.definition, opts("Go To Definition"))
                map('n', "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts("Hover Documentation"))
                map({ 'n', 'x' }, "grf", function() vim.lsp.buf.format({ async = true }) end,
                    opts("vim.lsp.buf.format()"))
            end
        })
    end
}

return M
