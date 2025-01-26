local backend = {}

local dirs = vim.uv.fs_scandir(vim.fn.stdpath("config").."/lua/lsp-backend/")
if not dirs then
    vim.notify("LSP-Backend config dir fail to scan!", vim.log.levels.ERROR)
    return backend
end

while true do
    local file, type = vim.uv.fs_scandir_next(dirs)
    if not file then
        break
    end

    if file ~= "init.lua" and type == 'file' then
        local modname = string.sub(file, 1, string.len(file) - 4)
        local config = require('lsp-backend.' .. modname)
        backend[modname] = config
    end
end


return backend
