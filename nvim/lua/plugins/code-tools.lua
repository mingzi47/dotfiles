return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_cfg = false
      })
    end,
    -- event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    -- if you need to install/update all binaries
    -- build = ':lua require("go.install").update_all_sync()'
  },
  {
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    config = false,
    dependencies = { "nvim-lspconfig" }
  }
}
