local pack = {
    'akinsho/toggleterm.nvim',
    config = true,
}

pack.opts = {
    autochdir = true,
    size = function(term)
        if term.direction == "horizontal" then
            return vim.o.lines * 0.3
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    on_open = function()
        vim.cmd("startinsert")
    end,
    on_close = function()
        vim.cmd("startinsert")
    end,
    winbar = {
        enabled = true,
        name_formatter = function(term)
            local path, number = string.match(term.name, "(.-);#toggleterm#(%d+)")
            return string.format("%s:%s", number, path)
        end
    },
}

local function feedkeys(keys)
    local key_termcode = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(key_termcode, 'n', false)
end

function _toggle_terminal_yazi()
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

                local timer = vim.uv.new_timer()
                for _, filename in ipairs(filenames) do
                    -- vim.cmd(infos.open .. ' ' .. filename)
                    timer:start(0, 0, vim.schedule_wrap(function()
                        vim.cmd(infos.open .. ' ' .. filename)
                    end))
                    -- feedkeys("<C-w>h")
                    -- feedkeys("<C-w>q")
                end

                vim.fn.delete(infos.tempname)
            end
        end
    })

    yazi:toggle()
end

function _toggle_terminal_git()
    local Terminal = require('toggleterm.terminal').Terminal
    local git = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        hidden = true,
        display_name = "Lazygit",
        direction = "float",
        float_opts = {
            border = "double",
            title_pos = "center",
        },
    })

    git:toggle()
end

function _toggle_terminal_horizontal_term()
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        direction = "horizontal",
    })

    term:toggle()
end

function _toggle_terminal_vertical_term()
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({
        direction = "vertical",
    })

    term:toggle()
end

function _toggle_terminal_float_term()
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
    { "<leader>ts", "<cmd>lua _toggle_terminal_horizontal_term()<CR>", desc = "Open Term" },
    { "<leader>tv", "<cmd>lua _toggle_terminal_vertical_term()<CR>",   desc = "Open Term Vert" },
    { "<leader>tf", "<cmd>lua _toggle_terminal_float_term()<CR>",      desc = "Open Term Float" },
    { "<leader>tt", "<cmd>ToggleTerm<CR>",                             desc = "Term Toggle" },
    { "<leader>g",  "<cmd>lua _toggle_terminal_git()<CR>",             desc = "Git" },
    { "<leader>e",  "<cmd>lua _toggle_terminal_yazi()<CR>",            desc = "Explorer" },
    -- { "<leader>tt", "<cmd>TermSelect<CR>",                             desc = "Term Select" },
}


-- keymap
function SetTermKeymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    vim.keymap.set('t', '<C-q>', "<cmd>ToggleTerm<cr>", opts)
end

vim.cmd('autocmd! TermOpen term://* lua SetTermKeymaps()')

return pack
