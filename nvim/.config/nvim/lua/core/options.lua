local opt = vim.opt

-- utf8
vim.g.encoding = "UTF-8"
opt.fileencoding = 'utf-8'

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.cursorcolumn = true

opt.signcolumn = "yes"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true
opt.shiftwidth = 2
opt.expandtab = true

opt.autoindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.autoread = true
opt.mouse = "a"

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 100

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true
opt.list = true
opt.shortmess = vim.o.shortmess .. 'c'

opt.background = 'dark'
opt.pumheight = 12
opt.clipboard:append 'unnamedplus'
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"
opt.fillchars:append "vert:▎"
opt.fillchars:append "horiz:▔"
opt.fillchars:append "eob: "

-- 禁用netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleder = " "
