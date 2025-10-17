local M = {
    'stevearc/oil.nvim',
    keys = {
        { "<leader>e", "<CMD>Oil<CR>", desc = "Open parent directory" }
    },
    opts = {
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        use_default_keymaps = false,
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-w>v"] = { "actions.select", opts = { vertical = true } },
            ["<C-w>s"] = { "actions.select", opts = { horizontal = true } },
            ["<C-w>t"] = { "actions.select", opts = { tab = true } },
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["<C-l>"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        confirmation = {
            border = "rounded",
        }
    },
}

return M
