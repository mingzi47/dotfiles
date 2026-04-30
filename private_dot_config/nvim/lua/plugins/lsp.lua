local M = {
    'neovim/nvim-lspconfig',
    event = { 'VeryLazy' },
    config = function()
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
