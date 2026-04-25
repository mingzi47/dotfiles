local M = {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
        ensure_installed = {
            "markdown",
            "markdown_inline",
            "latex",
            "html",
            "yaml",
            "bash",
            "diff",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "printf",
            "query",
            "regex",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "c",
            "rust",
            "cpp",
            "python",
            "go",
        },

        sync_install = false,
        auto_install = true,

        ignore_install = {},
        highlight = {
            enable = true
        },
    },
    -- config = function(_, opts)
    --     require("nvim-treesitter.configs").setup(opts)
    -- end,
}

return M
