local M = {
	'akinsho/toggleterm.nvim',
	config = true,
}

M.opts = {
    autochdir = true,
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    on_open = function(term)
        vim.cmd("startinsert")
    end,
    on_close = function(term)
        vim.cmd("startinsert")
    end,
}


function _toggle_terminal_fm()
    local Terminal  = require('toggleterm.terminal').Terminal
    local fm = Terminal:new({
        cmd = "yazi",
        display_name = "File Explorer",
        direction = "float",
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    })

    fm:toggle()
end


function _toggle_terminal_git()
    local Terminal = require('toggleterm.terminal').Terminal
    local git = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        display_name = "Lazygit",
        direction = "float",
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    })

    git:toggle()
end

function _toggle_terminal_just_run()
    local Terminal = require('toggleterm.terminal').Terminal
    local run = Terminal:new({
        cmd = "just run",
        display_name = "Run",
        direction = "horizontal",
        close_on_exit = false,
    })

    run:toggle()
end

function _toggle_terminal_just_debug()
    local Terminal = require('toggleterm.terminal').Terminal
    local debug = Terminal:new({
        cmd = "just debug",
        display_name = "Debug",
        direction = "horizontal",
        close_on_exit = false,
    })

    debug:toggle()
end

M.keys = {
    { "<leader>ts", "<cmd> 100ToggleTerm direction=horizontal<CR>", desc = "Open Term" },
    { "<leader>tv", "<cmd> 200ToggleTerm direction=vertical <CR>", desc = "Open Term Vert" },

    { "<leader>tf", "<cmd> 300ToggleTerm direction=float <CR>", desc = "Open Term [F]loat"},
    { "<leader>te", "<cmd>lua _toggle_terminal_fm()<CR>", desc = "Open File Explorer"},
    { "<leader>tg", "<cmd>lua _toggle_terminal_git()<CR>", desc = "Open Git"},
    { "<F5>", "<cmd>lua _toggle_terminal_just_run()<CR>", desc = "Justfile run"},
    { "<F6>", "<cmd>lua _toggle_terminal_just_debug()<CR>", desc = "Justfile debug"},
}

-- keymap
function SetTermKeymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
	vim.keymap.set('t', '<C-q>', [[<C-\><C-n><C-w>q]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua SetTermKeymaps()')

return M
