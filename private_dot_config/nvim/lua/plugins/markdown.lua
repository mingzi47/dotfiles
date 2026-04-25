local M = {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-mini/mini.icons'
    },
    opts = {
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
        require('mini.icons').setup()
        require("render-markdown").setup(opts)
    end
}


return M
