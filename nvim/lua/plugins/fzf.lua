local M = {
    "ibhagwan/fzf-lua",
    lazy = true,
    cmd = 'FzfLua',
}

M.config = function()
    local actions = require("fzf-lua").actions
    require("fzf-lua").setup({
        defaults = {
            file_icons = false,
        },
        winops   = {
            title = "Title",
            title_pos = "center",
            treesitter = { enabled = false },
            preview = {
                default = 'bat',
                wrap    = 'wrap',
            },
        },
        keymap   = {
            builtin = {
                ["<F1>"]  = "toggle-help",
                ["<C-d>"] = "preview-page-down",
                ["<C-u>"] = "preview-page-up",
            },
            fzf = {
                ['ctrl-q'] = "select-all+accept",
            }
        },
        actions  = {
            files = {
                ["enter"]  = actions.file_edit_or_qf,
                ["ctrl-s"] = actions.file_split,
                ["ctrl-v"] = actions.file_vsplit,
                ["ctrl-t"] = actions.file_tabedit,
            }
        }
    })
end

M.keys = {
    { "gr",             "<cmd>FzfLua lsp_references<cr>",                           desc = "Find Lsp References" },
    { "<leader>fb",     "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
    { "<leader>ff",     "<cmd>FzfLua files<cr>",                                    desc = "Find Files" },
    { "<leader>f<Tab>", "<cmd>FzfLua tabs<cr>",                                     desc = "Find Tabs" },
    { "<leader>fj",     "<cmd>FzfLua jumps<cr>",                                    desc = "Jumplist" },
    { "<leader>fc",     "<cmd>FzfLua commands<cr>",                                 desc = "Commands" },
    { "<leader>fs",     "<cmd>FzfLua lsp_document_symbols<cr>",                     desc = "Symbols" },
    { "<leader>fS",     "<cmd>FzfLua lsp_workspace_symbols<cr>",                    desc = "Symbols(WorkSpace)" },
    { "<leader>fd",     "<cmd>FzfLua diagnostics_document<cr>",                     desc = "Diagnostics" },
    { "<leader>fD",     "<cmd>FzfLua diagnostics_workspace<cr>",                    desc = "Diagnostics(WorkSpace)" },
    { "<leader>fw",     "<cmd>FzfLua live_grep<cr>",                                desc = "Grep" },
    { "<leader>fk",     "<cmd>FzfLua keymaps<cr>",                                  desc = "Keymaps" },
}

return M
