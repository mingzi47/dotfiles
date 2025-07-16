local map = vim.keymap.set
local unmap = vim.keymap.del

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
        on_open = function(term)
            local opts = { buffer = term.bufnr }
            vim.api.nvim_buf_set_name(term.bufnr, "Terminal")

            map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
            map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
            map('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
            map('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
            map('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
            map('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
            map('t', '<C-j>', [[<down>]], opts)
            map('t', '<C-k>', [[<up>]], opts)
            map('n', 'q', [[<cmd>close<cr>]], opts)
            map('n', 'q', function()
                vim.cmd('TermExec cmd=""')
                vim.cmd('TermExec cmd="exit"')
            end, opts)
        end,
        on_close = function()
            vim.print("yes")
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
        display_name = "Explorer",
        direction = "float",
        float_opts = {
            border = 'single',
            height = function()
                local ui = vim.api.nvim_list_uis()[1]
                vim.print(ui.height * 0.9)
                return math.floor(ui.height * 0.85)
            end,
            width = math.floor(vim.o.columns * 0.9),

        },
        on_open = function(term)
            local opts = { noremap = true, silent = true, buffer = term.bufnr }
            map("t", "<C-v>", function()
                infos.open = 'vsplit'
                vim.api.nvim_feedkeys("o", "n", false)
            end, opts)
            map("t", "<C-s>", function()
                infos.open = 'split'
                vim.api.nvim_feedkeys("o", "n", false)
            end, opts)
        end,
        on_close = function(term)
            local opts = { noremap = true, silent = true, buffer = term.bufnr }
            unmap("t", "<C-v>", opts)
            unmap("t", "<C-s>", opts)

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

function M.tab_term()
    return {
        direction = "tab",
    }
end

function M.input_command()
    local function format_data(data)
        local cleaned = {}
        for _, line in ipairs(data) do
            local cleaned_line = line:gsub('\x1b%[[%d;]*[A-Za-z]', '')
            cleaned_line = cleaned_line:gsub("\r", "")
            table.insert(cleaned, cleaned_line)
        end

        return cleaned
    end

    -- TODO
    -- local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local opts = {
        close_on_exit = false,
        on_open = function()
            -- clear qf
            vim.fn.setqflist({}, 'r')
        end,
        on_stdout = function(_, _, data)
            data = format_data(data)
            vim.fn.setqflist({}, "a", { lines = data })
        end,
        on_stderr = function(_, _, data)
            data = format_data(data)
            vim.fn.setqflist({}, "a", { lines = data })
        end
    }

    vim.ui.input({ prompt = 'Enter Command: ' }, function(input)
        opts.cmd = input
    end)

    return opts
end

M.keys = {
    { "<leader>e",      function() toggle(M.explorer()) end,      desc = "Explorer" },
    { "<leader>tt",     [[<Cmd>ToggleTerm<CR>]],                  desc = "term" },
    { "<leader>tv",     function() toggle(M.vsplit_term()) end,   desc = "vsplit" },
    { "<leader>ts",     function() toggle(M.split_term()) end,    desc = "split" },
    { "<leader>tf",     function() toggle(M.float_term()) end,    desc = "float" },
    { "<leader>t<tab>", function() toggle(M.tab_term()) end,      desc = "tab" },
    { "<leader>tc",     function() toggle(M.input_command()) end, desc = "Input Command" },
}


return M
