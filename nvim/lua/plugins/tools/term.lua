local config = {
	'akinsho/toggleterm.nvim',
	keys = {
		{ "<leader>tt", "<cmd> 1ToggleTerm <CR>", desc = "Open Term" },
		{ "<leader>tf", "<cmd> 2ToggleTerm direction=float <CR>", desc = "Open Term [F]loat"}
	},
	config = true,
}


-- keymap
function set_term_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_term_keymaps()')


return config
