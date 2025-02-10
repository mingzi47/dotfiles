local opts = {
    keymap = {
        preset = 'super-tab',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
    },
    completion = {
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
        cmdline = {},
    },
}

local cmp = {
    {
        'saghen/blink.cmp',
        event = { 'LspAttach', 'InsertEnter', 'CmdlineEnter' },
        version = '*',
        opts = opts,
        cond = function()
            return true
        end,
        build = "cargo build --release",
    },
}

return cmp
