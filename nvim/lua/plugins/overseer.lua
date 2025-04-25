local M = {
    'stevearc/overseer.nvim',
    keys = {
        { "<leader>oo", [[<cmd>OverseerToggle<cr>]], desc = "Toggle Task Window" },
        { "<leader>oc", [[<cmd>OverseerBuild<cr>]],  desc = "Open Task Builder" },
        { 
            "<leader>or",
            function ()
                require("fzf-lua").register_ui_select()
                vim.cmd([[OverseerRun]])
            end,
            desc = "List Task templates" 
        },
    },
}

M.opts = {
    strategy = {
        "toggleterm",
    },
    templates = { "builtin", },
    task_list = {
        direction = "right",
    },
}

return M
