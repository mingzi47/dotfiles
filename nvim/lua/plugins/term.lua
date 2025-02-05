local map = vim.keymap.set

local M = {
    'akinsho/toggleterm.nvim',
    lazy    = true,
    version = "*",
    opts    = {
        size = function(term)
            local ui = vim.api.nvim_list_uis()[1]
            if term.direction == "horizontal" then
                return ui.height / 2
            elseif term.direction == "vertical" then
                return ui.width / 2
            end
        end,
        on_open = function()
            local opts = { buffer = 0 }
            map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
            map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            map('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
            map('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
            map('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
            map('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
            map('n', 'q', [[<Cmd>close<CR>]], opts)
        end,
        on_close = function()
            vim.cmd("startinsert!")
        end,
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    }
}

local function toggle(opts)
    require('toggleterm.terminal').
        Terminal:new(opts):toggle()
end

function M.explorer()
    local infos = {
        workspace = vim.fn.getcwd(),
        filename = vim.api.nvim_buf_get_name(0),
        tempname = vim.fn.tempname(),
        open = 'edit', -- 'edit', 'split', 'vsplit'
    }

    return {
        cmd = ("yazi %s --chooser-file=%s"):format(infos.filename, infos.tempname),
        display_name = "yazi",
        direction = "float",
        on_open = function(term)
            local opts = { noremap = true, silent = true, buffer = term.buf }
            map("t", "<C-v>", function()
                infos.open = 'vsplit'
                vim.api.nvim_feedkeys("o", "n", false)
            end, opts)
            map("t", "<C-s>", function()
                infos.open = 'split'
                vim.api.nvim_feedkeys("o", "n", false)
            end, opts)
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
    }
end

function M.lazygit()
    return {
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        display_name = "lazygit",
    }
end

function M.float_term()
    return {
        direction = "float",
    }
end

function M.split_term()
    return {
        direction = "horizontal",
    }
end

function M.vsplit_term()
    return {
        direction = "vertical",
    }
end

function M.input_command()
    -- TODO
    -- local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local opts = {
        close_on_exit = false,
        on_open = function()
            -- clear qf
            vim.fn.setqflist({}, 'r')
        end,
        on_stdout = function(term, job, data)
            vim.fn.setqflist({}, "a", { lines = data })
        end,
        on_stderr = function(term, job, data)
            vim.fn.setqflist({}, "a", { lines = data })
        end
    }

    vim.ui.input({ prompt = 'Enter Command: ' }, function(input)
        opts.cmd = input
    end)

    return opts
end

M.keys = {
    { "<leader>g",  function() toggle(M.lazygit()) end,       desc = "Lazygit" },
    { "<leader>e",  function() toggle(M.explorer()) end,      desc = "Explorer" },
    { "<leader>tt", function() toggle(M.split_term()) end,    desc = "term" },
    { "<leader>tv", function() toggle(M.vsplit_term()) end,   desc = "vsplit" },
    { "<leader>tf", function() toggle(M.float_term()) end,    desc = "float" },
    { "<leader>tc", function() toggle(M.input_command()) end, desc = "Input Command" },

    { mode = "n",   "<leader>ts",                             [[<Cmd>ToggleTermSendCurrentLine<CR>]],     desc = "Send Command" },
    { mode = "v",   "<leader>ts",                             [[<Cmd>ToggleTermSendVisualSelection<CR>]], desc = "Send Command(Visual)" },
}


return M
