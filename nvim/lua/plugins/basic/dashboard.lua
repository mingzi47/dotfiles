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
                    desc = "Lazy",
                    group = 'DashboardShortCut',
                    key = 'l',
                    action = 'Lazy',
                },
                {
                    desc = "Sessions",
                    group = 'DashboardShortCut',
                    key = 's',
                    action = 'lua _open_sessions()',
                },
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
