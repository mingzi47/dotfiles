local pack = {
    "ibhagwan/fzf-lua",
    lazy = true,
    cmd = 'FzfLua',
    dependencies = { "echasnovski/mini.icons" },
}

pack.config = function()
    local actions = require("fzf-lua").actions
    require("fzf-lua").setup({
        winops = {
            title = "Title",
            title_pos = "center",
            treesitter = { enabled = false },
            preview = {
                wrap = 'wrap',
            },
        },
        actions = {
            files = {
                ["enter"]  = actions.file_edit_or_qf,
                ["ctrl-s"] = actions.file_split,
                ["ctrl-v"] = actions.file_vsplit,
                ["ctrl-t"] = actions.file_tabedit,
            }
        }
    })
end

pack.keys = {
    { "<leader>fb",     "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
    { "<leader>ff",     "<cmd>FzfLua files<cr>",                                    desc = "Find Files" },
    { "<leader>f<Tab>", "<cmd>FzfLua tabs<cr>",                                     desc = "Find Tabs" },
    { "<leader>fr",     "<cmd>FzfLua lsp_references<cr>",                           desc = "Find Lsp References" },
    { "<leader>fj",     "<cmd>FzfLua jumps<cr>",                                    desc = "Jumplist" },
    { "<leader>fc",     "<cmd>FzfLua command_history<cr>",                          desc = "Command History" },
    { "<leader>fC",     "<cmd>FzfLua commands<cr>",                                 desc = "Commands" },
    { "<leader>fs",     "<cmd>FzfLua lsp_document_symbols<cr>",                     desc = "Symbols" },
    { "<leader>fS",     "<cmd>FzfLua lsp_workspace_symbols<cr>",                    desc = "Symbols(WorkSpace)" },
    { "<leader>fd",     "<cmd>FzfLua diagnostics_document<cr>",                     desc = "Diagnostics" },
    { "<leader>fD",     "<cmd>FzfLua diagnostics_workspace<cr>",                    desc = "Diagnostics(WorkSpace)" },
    { "<leader>fw",     "<cmd>FzfLua live_grep<cr>",                                desc = "Grep" },
}

return pack
