local servers = {
	bashls = {},
	clangd = {},
	jsonls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = {
						"vim",
						"require",
					},
				},
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					callSnippet = "Replace",
				},
			},
			hint = {
				enable = true,
				arrayIndex = 'Enable',
				setType = true,
			},
		},
	},
	gopls = {}
}
return {
	{
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
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					"L3MON4D3/LuaSnip",
					dependencies = {
						"rafamadriz/friendly-snippets",
					},
				},
			},
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load({ path = { "~/.config/nvim/snippets" } })
			local luasnip = require("luasnip")
			local cmp = require("cmp")
			--local lspkind = require('lspkind')
			cmp.setup({
				window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
						border = "rounded",
						scrollbar = true,
					},
					documentation = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						border = "rounded",
						scrollbar = true,
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind =
							require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),

				experimental = {
					ghost_text = true,
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}),
			})
			-- lspkind highlight
			vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

			vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

			vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

			vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
			vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
			vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

			vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
		end,
	}
}
