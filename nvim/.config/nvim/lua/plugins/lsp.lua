return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        float = {
          source = "always",
          border = "rounded",
          style = "minimal",
        }
      })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {}
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {},
        },
      }
      lspconfig.clangd.setup {}
      lspconfig.lua_ls.setup {
        -- lua-langage-lsp
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
      -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.keymap.set('n', '<space>af', function()
            vim.lsp.buf.format { async = true }
          end, { buffer = ev.buf, desc = "format" })
        end,
      })
    end
  },

  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        scroll_preview = {
          scroll_down = "<C-j>",
          scroll_up = "<C-k>",
        },
        request_timeout = 2000,
        finder = {
          max_height = 0.5,
          min_width = 30,
          force_max_height = false,
          keys = {
            jump_to = 'p',
            expand_or_jump = 'o',
            vsplit = 'v',
            split = 's',
            tabe = 't',
            tabnew = 'r',
            quit = { 'q', '<ESC>' },
            close_in_preview = 'q',
          },
        },
        ui = {
          title = true,
          border = "rounded",
          winblend = 0,
          expand = "",
          collapse = "",
          code_action = "💡",
          incoming = " ",
          outgoing = " ",
          hover = ' ',
        },
      })
      local map = vim.keymap.set
      map("n", "<leader>lf", "<cmd>Lspsaga lsp_finder<CR>", { desc = "finder" })
      map({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "code action" })
      map("n", "<leader>lr", "<cmd>Lspsaga rename ++project<CR>", { desc = "rename" })
      map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "peek definition" })
      map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "goto definition" })

      map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

      map("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

      map("n", "<leader>ld", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { desc = "show all diagnostics" })

      map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "prev diagnostic" })
      map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "next diagnostic" })
      map("n", "[E", function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        { desc = "prev error" }
      )
      map("n", "]E", function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        { desc = "next error" }
      )

      map("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "open outline" })

      map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { desc = "open Hover Doc" })
      -- Call hierarchy
      -- map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      -- map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
      map({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", { desc = "open float term" })
    end
  },
}
