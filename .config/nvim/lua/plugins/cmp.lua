local M = {
    {
        'saghen/blink.cmp',
        event = { 'LspAttach', 'InsertEnter', 'CmdlineEnter' },
        version = '*',
        build = "cargo build --release",
        opts = {
            cmdline = { enabled = false },
            keymap = {
                preset = 'super-tab',
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
            },
            completion = {
                trigger = {
                    show_in_snippet = true,
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
        },
    },
}

return M
