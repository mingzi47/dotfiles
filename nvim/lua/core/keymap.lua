local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map({ "n", "o", "x" }, "gh", "^", { silent = true })
map({ "n", "o", "x" }, "gl", "$", { silent = true })

map({ "n", "o", "x" }, "gm", "%", { desc = "match" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc><right>", { desc = "Escape and Clear hlsearch" })

-- windwos size
map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- buffer
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bs", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", "<cmd>BufferDelete<cr>", { desc = "[B]uffer [D]elete" })

-- tab
map("n", "<leader><TAB>c", "<cmd>tabnew<cr>", {desc = "New Tab"})
map("n", "[<TAB>", "<cmd>tabprevious<cr>", {desc = "Prev Tab"})
map("n", "]<TAB>", "<cmd>tabnext<cr>", {desc = "Next Tab"})
map("n", "<leader><TAB>d", "<cmd>tabclose<cr>", {desc = "Close Tab"})

-- save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- quit
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Quit" })

-- better index
map("v", "<", "<gv")
map("v", ">", ">gv")

-- file
map("n", "<leader>fc", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>pl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>pq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })


-- action
map("n", "<leader>aw", ":cd ", { silent = false, desc = "Change Dir"})


-- windwos
map("n", "<leader>w", "<C-w>", {remap = true, desc = "+Win"})



-- neovide
if vim.g.neovide then
    map({"n", 'o', 'x'}, 'p', '"+p')
    map({'v', 'o', 'x'}, 'y', '"+y')
end


-- term

-- copy
map({'c'}, '<C-V>', '<C-R>+')
