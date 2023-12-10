local opt = vim.opt

-- utf8
vim.g.encoding = "UTF-8"
opt.fileencoding = 'utf-8'

opt.scrolloff = 2
opt.sidescrolloff = 2

opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.cursorcolumn = true

opt.signcolumn = "yes"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftround = true
opt.shiftwidth = 4
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
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.shortmess = vim.o.shortmess .. 'c'
-- opt.background = 'dark'
opt.pumheight = 12
opt.clipboard:append 'unnamedplus'

-- 禁用netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleder = " "



local signs = { Error = "\u{f057}", Warn = '\u{f071}', Hint = "\u{1F4A1}", Info = '\u{f449}' }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
