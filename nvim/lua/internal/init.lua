local autocmd = vim.api.nvim_create_autocmd
local ucommand = vim.api.nvim_create_user_command
local function augroup(name)
    return vim.api.nvim_create_augroup("mingzi_nvim_" .. name, { clear = true })
end

-- theme
vim.cmd("colorscheme gruvbox")
-- statusline
require("internal.statusline").setup()
-- keymap
require("internal.keymap")

-- auto pairs
autocmd({ 'InsertEnter', 'CmdlineEnter' },
    {
        group = augroup('editor'),
        once = true,
        callback = function()
            require 'internal.editor.pairs'
        end,

    })


-- buffer init
autocmd('BufEnter',
    {
        group = augroup('init'),
        once = true,
        callback = function()
        end,
    })
