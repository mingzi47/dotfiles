local map = vim.keymap.set
local del = vim.keymap.del

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

-- ahead, tail
map({ "n", "v", "o", "i", "t" }, "<C-a>", "^", { desc = "Go to Line ahead" })
map({ "n", "v", "o", "i", "t" }, "<C-e>", "$", { desc = "Go to Line tail" })

-- better up/down
map({ "n", "x" }, "j", "v:count==0?'gj':'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count==0?'gk':'k'", { desc = "Up", expr = true, silent = true })

map("i", "<C-h>", "<Left>", { desc = "Left", silent = true })
map("i", "<C-l>", "<Right>", { desc = "Right", silent = true })
map("i", "<C-k>", "<Up>", { desc = "Up", silent = true })
map("i", "<C-j>", "<Down>", { desc = "Down", silent = true })

-- Clear search on escape
map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

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
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })


-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })


-- window operator
map("n", "<leader>w", "<C-w>", { desc = "Window", remap = true })

map('n', "<F1>", '<cmd>qa<cr>', { desc = "Quit" })


-- Quickfix
local quickfix_toggle = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] then
            qf_exists = true
        end
    end

    if qf_exists then
        vim.cmd "cclose"
    elseif not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end

map("n", "<leader>q", quickfix_toggle, {desc = "Toggle Quickfix"})
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })


-- Buffer
map("n", "<leader>bv", "<cmd>vsplit Empty<cr>", {desc = "New Buffer vsplit"})
map("n", "<leader>bs", "<cmd>split Empty<cr>", {desc = "New Buffer split"})
map("n", "<leader>bc", "<cmd>enew<cr>", {desc = "New Buffer"})
map("n", "<leader>bd", "<cmd>bd!<cr>", {desc = "Delete Buffer"})
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })


-- message
map("n", "<leader>hm", "<cmd>enew|put=execute('messages')<cr>", { desc = "Messages History" })
