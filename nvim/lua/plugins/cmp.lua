local blink_opts = {
    keymap = {
        ['<Tab>'] = {
            "select_next",
            "snippet_forward",
            "fallback"
        },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
    },
    completion = {
        menu = {
            border = 'rounded',
        },
        ghost_text = { enabled = true },
        documentation = { auto_show = false, },
    },
    sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
        cmdline = {}
    },
    appearance = { kind_icons = require 'utils.icons'.kind },
}

local cmp = {
    {
        'saghen/blink.cmp',
        event = 'LspAttach',
        version = 'v0.*',
        opts = blink_opts,
    },
}

return cmp
