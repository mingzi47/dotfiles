local snacks_opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },

    -- disable
    dashboard = { enabled = false },
    indent = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
}

Snacks_Ex = {
    Explorer = function()
        local infos = {
            workspace = vim.fn.getcwd(),
            filename = vim.api.nvim_buf_get_name(0),
            tempname = vim.fn.tempname(),
            open = 'edit', -- 'edit', 'split', 'vsplit'
        }
        local cmd = { "yazi", "--chooser-file", infos.tempname }
        if infos.filename ~= nil and infos.filename ~= "" then
            table.insert(cmd, 2, infos.filename)
        end

        local terminal = Snacks.terminal.open(cmd, {
            cwd = infos.workspace,
            win = {
                position = "float",
                border = "rounded",
                title = "yazi",
                title_pos = "center",
                on_buf = function(self)
                    local utils = require("utils.fn")

                    vim.keymap.set("t", "<C-v>", function()
                        infos.open = 'vsplit'
                        utils.feedkeys("o", "n")
                    end, { noremap = true, silent = true, buffer = self.buf })

                    vim.keymap.set("t", "<C-s>", function()
                        infos.open = 'split'
                        utils.feedkeys("o", "n")
                    end, { noremap = true, silent = true, buffer = self.buf })
                end,
                on_close = function()
                    if vim.fn.filereadable(vim.fn.expand(infos.tempname)) == 1 then
                        local filenames = vim.fn.readfile(infos.tempname)
                        for _, filename in ipairs(filenames) do
                            vim.schedule(function()
                                vim.cmd(infos.open .. ' ' .. vim.fn.fnameescape(filename))
                            end)
                        end
                        vim.fn.delete(infos.tempname)
                    end
                end
            },
        })

        return terminal
    end
}


local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = snacks_opts,
    keys = {
        { "<leader>g",  function() Snacks.lazygit() end,     desc = "Lazygit" },
        { "<leader>tt", function() Snacks.terminal() end,    desc = "Toggle Terminal" },
        { "<leader>bd", function() Snacks.bufdelete() end,   desc = "Delete Buffer" },
        { "<leader>e",  function() Snacks_Ex.Explorer() end, desc = "Explorer" },
    }
}


return M
