local config = {
	"DreamMaoMao/yazi.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim"
	},
	keys = {
		{ "<leader>e", "<cmd>Yazi<CR>", desc = "File Explorer: [E]xplorer Yazi" },
	},
}

return config
