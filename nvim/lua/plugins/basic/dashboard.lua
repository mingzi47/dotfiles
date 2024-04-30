local M = {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}



M.config = function()

    require("dashboard").setup({
        theme = 'hyper',
        config = {
            week_header = { enable = true },
            shortcut = {
                {
                    icon = "\u{f04b2}\u{20}",
                    desc = "Lazy",
                    group = 'DashboardShortCut',
                    key = 'l',
                    action = 'Lazy',
                },
                {
                    icon = "\u{ea82}\u{20}",
                    desc = "Sessions",
                    group = 'DashboardShortCut',
                    key = 's',
                    action = 'lua _open_sessions()',
                },
                {
                    icon = "\u{f426}\u{20}",
                    desc = "Quit",
                    group = 'DashboardShortCut',
                    key = 'q',
                    action = 'qall!',
                }
            },
            project = {
                enable = false,
            },
            mru = {
                limit = 0,
                enable = false
            },
        }
    })
end


return M
