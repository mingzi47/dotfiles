return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "VeryLazy" },
    keys = {
        { "<leader>uh", [[<Cmd>TSToggle<CR>]], desc = "Treesitter" },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    init = function(plugin)
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    opts = {
        ensure_installed = {
            "bash",
            "diff",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "latex",
            "printf",
            "query",
            "regex",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
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
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
