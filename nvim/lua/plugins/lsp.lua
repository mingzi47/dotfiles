local frontend = {
    lua_ls = {
        cmd = {
            'lua-language-server',
            '--locale=zh-cn',
        },
        settings = {
            Lua = {
                diagnostics = {
                    unusedLocalExclude = { '_*' },
                    globals = { 'vim' },
                    disable = {
                        'luadoc-miss-see-name',
                        'undefined-field',
                    },
                },
                runtime = { version = 'LuaJIT' },
                workspace = {
                    library = {
                        vim.env.VIMRUNTIME .. '/lua',
                        '${3rd}/busted/library',
                        '${3rd}/luv/library',
                    },
                    checkThirdParty = false,
                },
                completion = { callSnippet = 'Replace' },
            },
        },
    },

    clangd = {
        capabilities = {
            textDocument = { completion = { completionItem = { snippetSupport = false } } },
        },
        cmd = {
            'clangd',
            '--background-index',
            '--header-insertion-decorators=false',
        },
        init_options = { fallbackFlags = { vim.bo.filetype == 'cpp' and '-std=c++23' or nil } },
        root_dir = function(fname)
            return require('lspconfig').util.root_pattern(unpack({
                '.git',
                'Makefile',
                'CMakeLists.txt',
                '.clangd',
                '.clang-tidy',
                '.clang-format',
            }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
        end,
    },
}

local backend = {}

function backend.lsp()
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


    -- keymap
    require("which-key").add({
        { "<leader>l",  group = "LSP" },
        { "gd",         vim.lsp.buf.definition,                             desc = "Go To Definition" },
        { 'gt',         "<c-t>",                                            desc = "Definition Back" },
        { "<leader>lf", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
    })
end

function backend.lspsaga()
    require('lspsaga').setup({
        ui = {
            devicon = false,
            border = 'single',
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
        { "<leader>ld", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "Lsp Diagnostics" },
        { "K",          "<cmd>Lspsaga hover_doc<CR>",                  desc = "Hover Documentation" },
        { "<F2>",       "<cmd>Lspsaga rename ++project<cr>",           desc = "Rename" },
        { "<leader>lo", "<cmd>Lspsaga outline<CR>",                    desc = "Lsp OutLine" }
    })
end

local lsp = {
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        config = backend.lsp,
    },
    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        config = backend.lspsaga,
    }
}

return lsp
