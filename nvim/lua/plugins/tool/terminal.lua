local M = {
	'akinsho/toggleterm.nvim',
	keys = {
		{ "<leader>t1", "<cmd> 1ToggleTerm <CR>", desc = "Open Term ID 1" },
		{ "<leader>t2", "<cmd> 2ToggleTerm <CR>", desc = "Open Term ID 2" },

		{ "<leader>tf", "<cmd> 10ToggleTerm direction=float <CR>", desc = "Open Term [F]loat"},
		{ "<leader>te", "<cmd> 11TermExec direction=float cmd='fm'<CR>", desc = "Open explore"},
	},
	config = true,
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
