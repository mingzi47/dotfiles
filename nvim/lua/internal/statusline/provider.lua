local p = {};
local utils = require("internal.statusline.utils")
local colors = require("utils.colors")
local icons = require("utils.icons")

--- =================================
---  Components
--- =================================
---

function p.sep_spacewhite()
    return ' '
end

function p.mode()
    return {
        stl = function()
            local mode = vim.api.nvim_get_mode().mode
            local m = utils.mode_alias[mode] or utils.mode_alias[string.sub(mode, 1, 1)] or 'UNK'

            vim.api.nvim_set_hl(0, 'StatusLinemode', {
                fg = utils.mode_colors[m],
            })
            return ('%s'):format(m:upper())
        end,
        name = 'mode',
        default = ' UNK ',
        event = { 'ModeChanged', 'BufEnter', 'TermLeave' },
        attr = {
        }
    }
end

function p.fileinfo()
    return {
        stl = function()
            return ('%s'):format([[%t]])
        end,
        name = 'fileinfo',
        event = { 'BufEnter' },
        attr = {
            fg = colors.magenta,
        }
    }
end

function p.progress()
    local spinner = { '⣶', '⣧', '⣏', '⡟', '⠿', '⢻', '⣹', '⣼' }
    local idx = 1
    return {
        stl = function(args)
            if args.data and args.data.params then
                local val = args.data.params.value
                if val.message and val.kind ~= 'end' then
                    idx = idx + 1 > #spinner and 1 or idx + 1
                    return ('%s'):format(spinner[idx - 1 > 0 and idx - 1 or 1])
                end
            end

            return ''
        end,
        name = 'LspProgress',
        event = { 'LspProgress' },
        attr = {
            fg = colors.fg5,
        }
    }
end

function p.lsp()
    return {
        stl = function(args)
            local client = vim.lsp.get_clients({ bufnr = 0 })[1]
            if not client then
                return ''
            end
            local msg = ''
            if args.data and args.data.params then
                local val = args.data.params.value
                if not val.message or val.kind == 'end' then
                    msg = ('[%s:%s]'):format(
                        client.name,
                        client.root_dir and vim.fn.fnamemodify(client.root_dir, ':t') or 'single'
                    )
                else
                    msg = ('%s %s%s'):format(
                        val.title,
                        (val.message and val.message .. ' ' or ''),
                        (val.percentage and val.percentage .. '%' or '')
                    )
                end
            elseif args.event == 'BufEnter' or args.event == 'LspAttach' then
                msg = ('[%s:%s]'):format(
                    client.name,
                    client.root_dir and vim.fn.fnamemodify(client.root_dir, ':t') or 'single'
                )
            elseif args.event == 'LspDetach' then
                msg = ''
            end
            return '   %-20s' .. msg
        end,
        name = 'LSP',
        event = { 'LspProgress', 'LspAttach', 'LspDetach', 'BufEnter' },
        attr = {
            fg = colors.white
        }
    }
end

function p.gitinfo()
    local alias = { 'Head', 'Add', 'Change', 'Delete' }
    local git_info_colors = { colors.magenta, colors.green, colors.orange, colors.red }
    for i = 1, 4 do
        vim.api.nvim_set_hl(0, 'StatusLineGit' .. alias[i], { fg = git_info_colors[i] })
    end
    return {
        stl = function()
            return coroutine.create(function(pieces, idx)
                local signs = { icons.git.branch, icons.git.added, icons.git.modified, icons.git.removed }
                local order = { 'head', 'added', 'changed', 'removed' }

                local ok, dict = pcall(vim.api.nvim_buf_get_var, 0, 'gitsigns_status_dict')
                if not ok or vim.tbl_isempty(dict) then
                    return ''
                end
                if dict['head'] == '' then
                    local co = coroutine.running()
                    vim.system(
                        { 'git', 'config', '--get', 'init.defaultBranch' },
                        { text = true },
                        function(result)
                            coroutine.resume(co, #result.stdout > 0 and vim.trim(result.stdout) or nil)
                        end
                    )
                    dict['head'] = coroutine.yield()
                end
                local parts = ''
                for i = 1, 4 do
                    if i == 1 or (type(dict[order[i]]) == 'number' and dict[order[i]] > 0) then
                        parts = ('%s %s'):format(parts, utils.group_fmt('Git', alias[i], signs[i] .. dict[order[i]]))
                    end
                end
                pieces[idx] = parts
            end)
        end,
        async = true,
        name = 'git',
        event = { 'User GitSignsUpdate', 'BufEnter' },
    }
end

function p.diagnostic()
    for i = 1, 3 do
        local name = ('Diagnostic%s'):format(vim.diagnostic.severity[i])
        local fg = vim.api.nvim_get_hl(0, { name = name }).fg
        vim.api.nvim_set_hl(0, 'StatusLine' .. vim.diagnostic.severity[i], { fg = fg })
    end

    return {
        stl = function()
            if not vim.diagnostic.is_enabled({ bufnr = 0 }) or #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
                return ''
            end
            local t = {}
            for i = 1, 3 do
                local count = #vim.diagnostic.get(0, { severity = i })
                t[#t + 1] = utils.stl_format(vim.diagnostic.severity[i], count)
            end
            return (' %s'):format(table.concat(t, ' '))
        end,
        name = 'diagnostic',
        event = { 'DiagnosticChanged', 'BufEnter', 'LspAttach' },
        attr = {
        }
    }
end

function p.encoding()
    return {
        stl = function()
            return ('%s'):format(vim.o.encoding)
        end,
        name = 'encoding',
        event = { 'BufEnter' },
        attr = {
            fg = colors.green
        }
    }
end

function p.rowcol()
    return {
        stl = function()
            return '%P %-2.(%l:%c%)'
        end,
        name = 'linecol',
        event = { 'BufEnter' },
        attr = {
            fg = colors.white,
        }
    }
end

function p.filesize()
    local size_unit = { 'b', 'k', 'm', 'g' }
    return {
        stl = function()
            local size = vim.fn.getfsize(vim.fn.expand('%'))
            local idx = 1
            while size >= 1024 and idx < #size_unit do
                size = size / 1024
                idx = idx + 1
            end
            vim.api.nvim_buf_get_name(0)
            return ('%.1f%s'):format(size, size_unit[idx])
        end,
        name = 'filesize',
        event = { 'BufEnter', 'BufModifiedSet' },
        attr = {
            fg = colors.white,
        }
    }
end

return p
