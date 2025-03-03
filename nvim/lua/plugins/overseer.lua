local M = {
    'stevearc/overseer.nvim',
    keys = {
        { "<leader>oo", [[<cmd>OverseerToggle<cr>]], desc = "Toggle Task Window" },
        { "<leader>oc", [[<cmd>OverseerBuild<cr>]],  desc = "Open Task Builder" },
        { "<leader>or", [[<cmd>OverseerRun<cr>]],    desc = "List Task templates" },
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
