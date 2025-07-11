local map = vim.keymap.set

---*Map table:*
--- KEY      | a n b i c v x s o t l
-------------|-----------------------
--- Normal   | ✓ ✓
--- Insert   |     ✓ ✓             ✓
--- Command  |     ✓   ✓
--- Visual   | ✓         ✓ ✓
--- Select   | ✓         ✓   ✓
--- Operator |                 ✓
--- Terminal |                   ✓
--- Lang-Arg |                     ✓

-- better up/down
map({ "n", "x" }, "j", "v:count==0?'gj':'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count==0?'gk':'k'", { desc = "Up", expr = true, silent = true })

map({ "n", "v", "o"}, "gh", "^", { desc = "Line Head", silent = true })
map({ "n", "v", "o"}, "gl", "$", { desc = "Line tail", silent = true })

map({ "i", "c" }, "<C-h>", "<Left>", { desc = "Left", silent = true })
map({ "i", "c" }, "<C-l>", "<Right>", { desc = "Right", silent = true })
map({ "i", "c" }, "<C-k>", "<Up>", { desc = "Up", silent = true })
map({ "i", "c" }, "<C-j>", "<Down>", { desc = "Down", silent = true })

-- Clear search on escape
map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map('n', "<C-c>", '<cmd>qa<cr>', { desc = "Quit" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- diagnostic
local diagnostic_goto = function(next, severity)
    local jump = vim.diagnostic.jump
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        jump({
            count = next,
            severity = severity
        })
    end
end
map("n", "]d", diagnostic_goto(1), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(-1), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(1, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(-1, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(1, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(-1, "WARN"), { desc = "Prev Warning" })


-- window operator
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- <c-w>o :only


-- Quickfix
local quickfix_toggle = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 1 then
            qf_exists = true
        end
    end

    if qf_exists then
        vim.cmd "cclose"
    elseif not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end

map("n", "<leader>q", quickfix_toggle, { desc = "Toggle Quickfix" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })


-- Buffer
map("n", "<leader>bv", "<cmd>vsplit Empty<cr>", { desc = "New Buffer vsplit" })
map("n", "<leader>bs", "<cmd>split Empty<cr>", { desc = "New Buffer split" })
map("n", "<leader>bc", "<cmd>enew<cr>", { desc = "New Buffer" })
map("n", "<leader>bd", "<cmd>bd!<cr>", {desc = "Delete Buffer"})
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })


-- Lazy Pane
map("n", "<F10>", "<cmd>Lazy<cr>", { desc = "Lazy" })


-- comment(build-in)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })


-- match
map({ "n", "o", 'x', 'v' }, "gm", "%", { desc = "matchit" })
