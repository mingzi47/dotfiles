local sessions = require('mini.sessions')
-- local telescope = require('telescope')
local actions = require('telescope.actions')
local actions_state = require("telescope.actions.state")
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
-- local previewers = require('telescope.previewers')
local conf = require('telescope.config').values


-- session name of mini.session == session real path.
-- NOTE: Because session names cannot contain the '/' character, it has been replaced.
local H = {}

H.path_replace_symbols = '|~|'

H.path_to_string = function(path)
    local str = string.gsub(path, '/', H.path_replace_symbols)

    return str
end

H.string_to_path = function(str)
    local path = string.gsub(str, H.path_replace_symbols, '/')

    return path
end

local M = {}

M.action_save = function(prompt_bufnr)
    local pwd = vim.fn.getcwd()
    -- local session_name = vim.fn.fnamemodify(pwd, ':p:h:t')
    local session_name = H.path_to_string(pwd)

    sessions.write(session_name)
end

M.action_open = function(prompt_bufnr)
    if prompt_bufnr == nil then
        return
    end
    local path_name = actions_state.get_selected_entry(prompt_bufnr).value
    local session_name = H.path_to_string(path_name)

    sessions.read(session_name)
end

M.action_delete = function(prompt_bufnr)
    if prompt_bufnr == nil then
        return
    end
    local path_name = actions_state.get_selected_entry(prompt_bufnr).value
    local session_name = H.path_to_string(path_name)

    sessions.delete(session_name, {
        force = true
    })
end

M.action_empty = function(prompt_bufnr)
end

M.mappings = {
    n = {
        ["o"] = { action = M.action_open, exit_on_action = true },
        ["<CR>"] = { action = M.action_open, exit_on_action = true },
        ["w"] = { action = M.action_save, exit_on_action = false },
        ["d"] = { action = M.action_delete, exit_on_action = false },
        ["s"] = { action = M.action_empty },
        ["v"] = { action = M.action_empty },
        ["t"] = { action = M.action_empty },
    },
}

M.picker = function(opts)
    opts = opts or {}
    local session_list = {}
    for session_name, _ in pairs(sessions.detected) do
        table.insert(session_list, H.string_to_path(session_name))
    end

    pickers.new(opts, {
        prompt_title = "Sessions",
        finder = finders.new_table {
            results = session_list
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            for mode, mode_mappings in pairs(M.mappings) do
                for keybind, action_tbl in pairs(mode_mappings) do
                    map(mode, keybind, function()
                        action_tbl["action"](prompt_bufnr)
                    end)
                end
            end

            actions.select_default:replace(function() end)
            return true
        end,
    }):find()
end

return M
