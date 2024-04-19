local M = {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPost", "BufNewFile" },
    event = "UIEnter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
}

M.config = function()
    require('nvim-treesitter.configs').setup({
        sysc_install = true,
        auto_install = true,
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "go",
            "json",
            "javascript",
            "lua",
            "markdown",
            "markdown_inline",
            "typescript",
            "vim",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "outer fuction" },
                    ["if"] = { query = "@function.inner", desc = "inner function" },
                    ["ac"] = { query = "@class.outer", desc = "outer class" },
                    ["ic"] = { query = "@class.inner", desc = "inner class" },
                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                },
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                include_surrounding_whitespace = false,
            },
        },
    })
end


return M
