local lspconfig = require('lspconfig')

-- python
lspconfig.pyright.setup {}

-- rust
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- cpp
lspconfig.clangd.setup {}

-- lua
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