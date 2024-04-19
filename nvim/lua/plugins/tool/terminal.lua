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


M.keys = {
    { "<leader>ts", "<cmd> 1ToggleTerm direction=horizontal<CR>", desc = "Open Term" },
    { "<leader>tv", "<cmd> 2ToggleTerm direction=vertical <CR>", desc = "Open Term Vert" },

    { "<leader>tf", "<cmd> 10ToggleTerm direction=float <CR>", desc = "Open Term [F]loat"},
    { "<leader>te", "<cmd>lua _toggle_terminal_fm()<CR>", desc = "Open File Explorer"},
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
