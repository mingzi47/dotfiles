local mappings = {
	{
		from = "gh",
		to = "^",
		mode = { "n", "o", "x" },
		opt = {
			desc = "go Line Head" }
	},
	{
		from = "gl",
		to = "$",
		mode = { "n", "o", "x" },
		opt = {
			desc = "go Line End" }
	},
	{
		from = "gm",
		to = "%",
		mode = { "n", "o", "x" },
		opt = {
			desc = "match" }
	},
	{
		from = "gw",
		to = "*N",
		mode = { "n", "x" },
		opt = {
			desc = "Search word under cursor" }
	},
	{
		from = "n",
		to = "'Nn'[v:searchforward]",
		mode = { "n", "x", "o" },
		opt = {
			expr = true, desc = "Next search result" }
	},
	{
		from = "N",
		to = "'nN'[v:searchforward]",
		mode = { "n", "x", "o" },
		opt = {
			expr = true, desc = "Prev search result" }
	},
	{ from = "j",              to = "v:count == 0 ? 'gj' : 'j'", opt = { expr = true } },
	{ from = "k",              to = "v:count == 0 ? 'gk' : 'k'", opt = { expr = true } },
	{ from = "<esc>",          to = "<cmd>noh<cr><esc><right>",  mode = { "n", "i" } },
	{ from = "<C-j>",          to = "10j",                       mode = { "n", "v" } },
	{ from = "<C-k>",          to = "10k",                       mode = { "n", "v" } },
	{ from = "<C-h>",          to = "<left>",                    mode = { "i" } },
	{ from = "<C-l>",          to = "<right>",                   mode = { "i" } },
	-- tab
	{ from = "<leader><tab>c", to = "<cmd>tabnew<cr>",           opt = { desc = "Tab: [Tab] [C]reate" } },
	{ from = "]<tab>",         to = "<cmd>tabnext<cr>",          opt = { desc = "Tab: Next [Tab]" } },
	{ from = "<leader><tab>d", to = "<cmd>tabclose<cr>",         opt = { desc = "Tab: [Tab] [D]elete" } },
	{ from = "[<tab>",         to = "<cmd>tabprevious<cr>",      opt = { desc = "Tab: Prev [Tab]" } },
	-- file
	{ from = "<leader>bc",     to = "<cmd>enew<cr>",             opt = { desc = "Buffer: [B]uffer [C]reate" } },
	{ from = "<leader>bd",     to = "<cmd>BufferDelete<cr>",     opt = { desc = "Buffer: [B]uffer [D]elete" } },
	{ from = "[b",             to = "<cmd>bp<cr>",               opt = { desc = "Buffer: Prev [B]uffer" } },
	{ from = "]b",             to = "<cmd>bn<cr>",               opt = { desc = "Buffer: Next [B]uffer" } },
	{ from = "<leader>aw",     to = "<cmd>wa!<cr>",              opt = { desc = "Action : Vim [A]ction [W]rite" } },
	{ from = "<leader>aq",     to = "<cmd>qa!<cr>",              opt = { desc = "Action : Vim [A]ction [Q]uit" } },
}



for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, mapping.opt)
end

-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = '*.md',
--   callback = function()
--     for _, mapping in ipairs(MdSnippets) do
--       vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, mapping.opt)
--     end
--   end
-- })
--
