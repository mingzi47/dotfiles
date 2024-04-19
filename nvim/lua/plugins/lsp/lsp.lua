local servers = require 'plugins.lsp.language.config'
local tool = require 'plugins.lsp.tool.tool'

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap('gt', "<c-t>", "Definition Back")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>af", function() vim.lsp.buf.format { async = true } end, "[A]ction [F]ormat")
    nmap("<leader>ld", "<cmd>Lspsaga peek_definition<CR>", "[L]sp [D]efinition")
    nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
    nmap("<leader>ar", "<cmd>Lspsaga rename ++project<cr>", "[A]ction [R]ename")
    nmap("<leader>ac", "<cmd>Lspsaga code_action<CR>", "[A]ction Code")
    nmap("<leader>lo", "<cmd>Lspsaga outline<CR>", "[L]sp [O]utLine")
    nmap('gr', vim.lsp.buf.references, "[G]oto [R]eference")
    -- vim.lsp.inlay_hint(bufnr, true)
end

local CMP = {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		'hrsh7th/cmp-cmdline',
		"onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
	},
}

CMP.config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load({ path = { "~/.config/nvim/snippets" } })

    local luasnip = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
                border = "rounded",
                scrollbar = true,
            },
            documentation = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                border = "rounded",
                scrollbar = true,
            },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind =
                    require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                return kind
            end,
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        experimental = {
            ghost_text = true,
        },
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    tool.CMPIconSetHighLight()
end


local LSP = {
    "neovim/nvim-lspconfig",
	-- event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
	dependencies = {
		"nvimdev/lspsaga.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}


LSP.config = function()
    require "lspsaga".setup({
        outline = {
            layout = "float",
            keys = {
                quit = "q",
                toggle_or_jump = "<cr>",
            }
        },
        rename = {
            quit = "<esc>",
        },
    })

    local capabilities = require "cmp_nvim_lsp".default_capabilities()

    for server, config in pairs(servers) do
        require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
            on_attach = on_attach,
            capabilities = capabilities,
        }, config))
    end
end


return {
    LSP,
    CMP
}
