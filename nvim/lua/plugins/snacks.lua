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

        local setkey = function(buffer_id)
            local utils = require("utils.fn")
            vim.keymap.set("t", "<C-v>", function()
                infos.open = 'vsplit'
                utils.feedkeys("o", "n")
            end, { noremap = true, silent = true, buffer = buffer_id })

            vim.keymap.set("t", "<C-s>", function()
                infos.open = 'split'
                utils.feedkeys("o", "n")
            end, { noremap = true, silent = true, buffer = buffer_id })
        end

        local openfile = function()
            if vim.fn.filereadable(vim.fn.expand(infos.tempname)) == 1 then
                local filenames = vim.fn.readfile(infos.tempname)

                for _, filename in ipairs(filenames) do
                    vim.defer_fn(
                        vim.schedule_wrap(function()
                            vim.cmd(infos.open .. ' ' .. filename)
                        end), 0)
                end

                vim.fn.delete(infos.tempname)
            end
        end

        local id = vim.v.count1
        local cmd = ("yazi %s --chooser-file='%s'"):format(infos.filename, infos.tempname)
        local defaults = { win = { style = "terminal" } }
        local opts = Snacks.config.get("terminal", defaults --[[@as snacks.terminal.Opts]], {})
        opts.win = Snacks.win.resolve("terminal", { position = "float", border = "rounded" }, opts.win)
        local on_buf = opts.win and opts.win.on_buf

        ---@param self snacks.terminal
        opts.win.on_buf = function(self)
            self.cmd = cmd
            vim.b[self.buf].snacks_terminal = { cmd = cmd, id = id }
            if on_buf then
                on_buf(self)
            end
        end

        local terminal = Snacks.win(opts.win)

        vim.api.nvim_buf_call(terminal.buf, function()
            vim.fn.termopen(cmd)
            setkey(terminal.buf)
        end)

        if opts.interactive ~= false then
            vim.cmd.startinsert()
            vim.api.nvim_create_autocmd("TermClose", {
                once = true,
                buffer = terminal.buf,
                callback = function()
                    if type(vim.v.event) == "table" and vim.v.event.status ~= 0 then
                        Snacks.notify.error("Terminal exited with code " ..
                            vim.v.event.status .. ".\nCheck for any errors.")
                        return
                    end
                    terminal:close()
                    openfile()

                    vim.cmd.checktime()
                end,
            })
            vim.api.nvim_create_autocmd("BufEnter", {
                buffer = terminal.buf,
                callback = function()
                    vim.cmd.startinsert()
                end,
            })
            terminal:on("ExitPre", function()
                terminal:close()

                openfile()
            end)
        end
        vim.cmd("noh")
        return terminal
    end,
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
