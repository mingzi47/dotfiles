local servers = require 'plugins.lsp.language.config'

local config = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvimdev/lspsaga.nvim",
	},
	config = function()
		local on_attach = function(_, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end

				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end
			nmap('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			nmap("<leader>af", function() vim.lsp.buf.format { async = true } end, "[A]ction [F]ormat")
			nmap("<leader>ld", "<cmd>Lspsaga peek_definition<CR>", "[L]sp [D]efinition")
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto/Find [R]eferences")
			nmap("K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			nmap("<leader>ar", "<cmd>Lspsaga rename ++project<cr>", "[A]ction [R]ename")
			nmap("<leader>ac", "<cmd>Lspsaga code_action<CR>", "[A]ction Code")
			nmap("<leader>lo", "<cmd>Lspsaga outline<CR>", "[L]sp [O]utLine")
			nmap("<leader>fd", require("telescope.builtin").diagnostics, "[f]ind [D]iagnostics")
			nmap('[d', vim.diagnostic.goto_prev, "Prev [D]iagnostic")
			nmap(']d', vim.diagnostic.goto_next, "Next [D]iagnostic")

			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			-- vim.lsp.inlay_hint(bufnr, true)
		end
		require("lspsaga").setup({
			outline = {
				layout = "float",
				keys = {
					quit = "q",
					toggle_or_jump = "<cr>",
				}
			},
			rename = {
				quit = "<esc>",
			},
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for server, config in pairs(servers) do
			require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, config))
		end
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = 'rounded',
					source = 'always',
					prefix = ' ',
					scope = 'cursor',
				}
				vim.diagnostic.open_float(nil, opts)
			end
		})
	end,
}

return config
