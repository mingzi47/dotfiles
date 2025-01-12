local blink_opts = {
    keymap = {
        preset = 'super-tab',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
    },
    completion = {
        list = {
            selection = {
                preselect = function(ctx)
                    return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
                end,
                auto_insert = function(ctx)
                    return ctx.mode ~= 'cmdline'
                end,
            },
        },
        trigger = {
            show_in_snippet = false,
        },
        menu = {
            auto_show = true,
            border = 'rounded',
        },
        ghost_text = { enabled = true },
        documentation = { auto_show = false, },
    },
    sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
    },
    appearance = { kind_icons = require 'utils.icons'.kind },
}

local cmp = {
    {
        'saghen/blink.cmp',
        event = 'LspAttach',
        version = '*',
        opts = blink_opts,
    },
}

return cmp
