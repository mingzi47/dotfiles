local M = {
    "AstroNvim/astrotheme",
    lazy = false,
    priority = 1000,
}

local transparent = true

if vim.g.neovide then
    transparent = false
end

M.config = function()
    require("astrotheme").setup({
        palette = "astrodark",
        style = {
            transparent = transparent,
            italic_comments = false,
        },
    })
    -- setup must be called before loading
    vim.cmd.colorscheme "astrotheme"
end

return M
