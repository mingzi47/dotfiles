local backend = require("lsp-backend")

local frontend = {}

function frontend.lsp()
    local on_attach = function(client, _)
        vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
        client.server_capabilities.semanticTokensProvider = nil
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    for server, conf in pairs(backend) do
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


    -- keymap
    require("which-key").add({
        { "<leader>l",  group = "LSP" },
        { "gd",         vim.lsp.buf.definition,                             desc = "Go To Definition" },
        { "<leader>lf", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
    })
end

function frontend.lspsaga()
    require('lspsaga').setup({
        ui = {
            devicon = false,
            border = 'rounded',
        },
        outline = {
            layout = "float",
            keys = {
                quit = 'q',
                toggle_or_jump = '<cr>',
            },
        },
        rename = {
            quit = "<esc>",
        },
        finder = {
            keys = {
                edit = '<C-o>',
                toggle_or_open = '<cr>',
            },
        },
        definition = {
            keys = {
                edit = '<C-o>',
                vsplit = '<C-v>',
            },
        },
    })

    require("which-key").add({
        { "K",           "<cmd>Lspsaga hover_doc<CR>",        desc = "Hover Documentation" },
        { "<F2>",        "<cmd>Lspsaga rename ++project<cr>", desc = "Rename" },
        { "<leader>la",  "<cmd>Lspsaga code_action<cr>",      desc = "Lsp Code Action" },
    })
end

local lsp = {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = frontend.lsp,
    },
    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        config = frontend.lspsaga,
    }
}

return lsp
