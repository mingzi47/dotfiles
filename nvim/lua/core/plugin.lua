local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        -- "git@github.com:folke/lazy.nvim.git",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
    },
    git = {
        log = { "--since=3 days ago" }, -- show commits from the last 3 days
        timeout = 120,            -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
        filter = true,
    },
    ui = {
        size = { width = 0.7, height = 0.7 },
        border = "rounded",
        title = "LAZY",
        title_pos = "center",
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
