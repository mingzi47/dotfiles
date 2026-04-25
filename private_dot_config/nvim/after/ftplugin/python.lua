local setup_lsp = require("utils.tools").setup_lsp
setup_lsp("ruff", {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
})


setup_lsp("pyright", {})
