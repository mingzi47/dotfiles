return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      inlay_hints = { enabled = true },
    },
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

      require("lsp.config")

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "lsp definition", buffer = ev.buf })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "lsp implementation", buffer = ev.buf })
          vim.keymap.set('n', '<space>af', function()
            vim.lsp.buf.format { async = true }
          end, { buffer = ev.buf, desc = "format" })
        end,
      })
    end
  },
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>pm", "<cmd> Mason<CR>", desc = "Mason(lsp install)" },
    },
    config = function()
      require("mason").setup({
        github = {
          download_url_template = "https://github.com/%s/releases/download/%s/%s",
        },
        ui = {
          border = "rounded",
          height = 0.7,
          width = 0.7,
        }
      })
    end,
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
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 25,
          preview_width = 0.4,
          show_detail = true,
          auto_preview = false,
          auto_refresh = true,
          auto_close = true,
          auto_resize = false,
          custom_sort = nil,
          keys = {
            expand_or_jump = 'o',
            quit = "q",
          },
        },
        ui = {
          title = true,
          border = "rounded",
        },
      })
      local map = vim.keymap.set
      map("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "finder" })
      map({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "code action" })
      map("n", "<leader>lr", "<cmd>Lspsaga rename ++project<CR>", { desc = "rename" })
      map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "peek definition" })

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

      map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "open Hover Doc" })
      -- Call hierarchy
      -- map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      -- map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    end
  },
}
