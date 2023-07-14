return {
  {
    'akinsho/bufferline.nvim',
    lazy = true,
    event = 'VeryLazy',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local map = vim.keymap.set;
      map({ "n" }, "<leader>bd", "<cmd>BufferDelete<CR>", { silent = true, noremap = true, desc = "Delete buffer" })
      map({ "n" }, "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true, noremap = true, desc = "Next buffer" })
      map({ "n" }, "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { silent = true, noremap = true, desc = "Prev buffer" })
      require("bufferline").setup({
        options = {
          buffer_close_icon = '󰅖 ',
          modified_icon = '●',
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true
            },
            {
              filetype = "lspsagaoutline",
              text = "LSP Symbols",
              text_align = "center",
              separator = true
            }
          },
        }
      })
    end
  }
}
