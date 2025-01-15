local pack = {
    'akinsho/toggleterm.nvim',
    config = true,
}

pack.opts = {
    autochdir = true,
    size = function(term)
        if term.direction == "horizontal" then
            return vim.o.lines * 0.5
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
        end
    end,
    on_open = function()
        vim.cmd("startinsert")
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        vim.keymap.set('t', '<F1>', "<cmd>ToggleTerm<cr>", opts)
    end,
    on_close = function()
    end,
    winbar = {
        enabled = false,
    },
}

local function feedkeys(keys)
    local key_termcode = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(key_termcode, 'n', false)
end

local function toggle_terminal_run()
    local Terminal = require("toggleterm.terminal").Terminal
    local run = Terminal:new({
        cmd = "just run",
        direction = "horizontal",
        close_on_exit = false,
    })

    run:toggle()
end

local function toggle_terminal_yazi()
    local Terminal = require('toggleterm.terminal').Terminal
    local infos = {
        workspace = vim.fn.getcwd(),
        filename = vim.api.nvim_buf_get_name(0),
        tempname = vim.fn.tempname(),
        open = 'edit', -- 'edit', 'split', 'vsplit'
    }
    local yazi = Terminal:new({
        cmd = string.format("yazi %s --chooser-file='%s'", infos.filename, infos.tempname),
        display_name = "Yazi",
        direction = "float",
        hidden = true,
        float_opts = {
            border = "double",
            title_pos = "center",
        },
        on_open = function(term)
            vim.keymap.set("t", "<C-v>", function()
                infos.open = 'vsplit'
                feedkeys("o")
            end, { noremap = true, silent = true, buffer = term.bufnr })

            vim.keymap.set("t", "<C-s>", function()
                infos.open = 'split'
                feedkeys("o")
            end, { noremap = true, silent = true, buffer = term.bufnr })
        end,
        on_exit = function()
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
    })

    yazi:toggle()
end

local function toggle_terminal_git()
    local Terminal = require('toggleterm.terminal').Terminal
    local git = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        hidden = true,
        display_name = "Lazygit",
        direction = "tab",
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    })

    git:toggle()
end

local function toggle_terminal_horizontal_term()
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        direction = "horizontal",
    })

    term:toggle()
end

local function toggle_terminal_vertical_term()
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        direction = "vertical",
    })

    term:toggle()
end

local function toggle_terminal_float_term()
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        direction = "float",
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    })

    term:toggle()
end

pack.keys = {
    { "<leader>ts", toggle_terminal_horizontal_term, desc = "Open Term" },
    { "<leader>tv", toggle_terminal_vertical_term,   desc = "Open Term Vert" },
    { "<leader>tf", toggle_terminal_float_term,      desc = "Open Term Float" },
    { "<leader>tt", "<cmd>ToggleTerm<CR>",           desc = "Term Toggle" },
    { "<leader>g",  toggle_terminal_git,             desc = "Git" },
    { "<leader>e",  toggle_terminal_yazi,            desc = "Explorer" },
    { "<F5>",       toggle_terminal_run,             desc = "Run (Justfile)" },
    -- { "<leader>tt", "<cmd>TermSelect<CR>",                             desc = "Term Select" },
}


return pack
