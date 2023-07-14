local map = vim.keymap.set

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc><right>", { desc = "Escape and clear hlsearch" })

map({ "n", "o", "x" }, "ga", "^", { noremap = false, silent = true, desc = "Line head" })
map({ "n", "o", "x" }, "ge", "$", { noremap = false, silent = true, desc = "Line end" })

map({ "n", "o", "x" }, "J", "10j", { noremap = false, silent = true })
map({ "n", "o", "x" }, "K", "10k", { noremap = false, silent = true })

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map({ "n", "o", "x" }, "gm", "%", { noremap = false, silent = true, desc = "match" })

map({ "i" }, "<C-h>", "<left>", { noremap = false, silent = true })
map({ "i" }, "<C-l>", "<right>", { noremap = false, silent = true })


map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-l>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-h>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader><tab>c", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>n", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>p", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor", noremap = false, silent = true })
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]",
  { expr = true, desc = "Next search result", noremap = false, silent = true })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]",
  { expr = true, desc = "Prev search result", noremap = false, silent = true })

map("n", "<leader>fc", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>fd", "<cmd>BufferDelete<cr>", { desc = "Close File" })
map("n", "<leader>fw", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>fW", "<cmd>wa<cr>", { desc = "Save All Files" })

-- map("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Prev Buffer", noremap = true })
-- map("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next Buffer", noremap = true })
-- map("n", "<leader>bd", "<cmd>BufferDelete<cr>", { desc = "Delete Buffer", noremap = true })
map("n", "<leader>bw", "<cmd>w<cr>", { desc = "Save Buffer" })
map("n", "<leader>bW", "<cmd>wa<cr>", { desc = "Save All Buffers" })

map("n", "<leader>ww", "<C-w>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window right" })
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to below window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to top window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equally high and wide" })
map("n", "<leader>wx", "<C-w>x", { desc = "Swap current with next" })


