return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			-- Run gofmt + goimport on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require('go.format').goimport()
				end,
				group = vim.api.nvim_create_augroup("GoFormat", {}),
			})

			require("go").setup()
		end,
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()'
	}
}
