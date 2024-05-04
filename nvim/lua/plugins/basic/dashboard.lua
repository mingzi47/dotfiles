local M = {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    keys = {
        { "<leader>pd", "<cmd>Dashboard<cr>", desc = "[P]ane [D]ashboard" }
    },
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
                    icon = "\u{f120}\u{20}",
                    desc = "Terminal",
                    group = 'DashboardShortCut',
                    key = 't',
                    action = 'lua _toggle_terminal_horizontal_term()',
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
