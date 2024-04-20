local M = {
    "askfiy/visual_studio_code",
    lazy = false,
    priority = 1000,
}

local transparent = true

if vim.g.neovide then
    transparent = false
end

M.config = function()
    require("visual_studio_code").setup({
        mode = "dark",
        transparent = transparent, -- Enable this to disable setting the background color
    })
    -- setup must be called before loading
    vim.cmd.colorscheme "visual_studio_code"
end

return M
