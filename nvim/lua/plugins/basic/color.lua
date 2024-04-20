local M = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
}

M.config = function()
    -- Default options
    require('nightfox').setup({
        options = {
            transparent = false,    -- Disable setting background
            terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
            dim_inactive = true,    -- Non focused panes set to alternative background
            module_default = true,  -- Default enable value for modules
        },
        palettes = {
            carbonfox = {
                comment = "#4f733f",
            }
        },
    })

    vim.cmd.colorscheme "carbonfox"
end



return M
