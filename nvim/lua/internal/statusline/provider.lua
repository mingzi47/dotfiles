local p = {};
local utils = require("internal.statusline.utils")
local colors = require("utils.colors")

--- =================================
---  Components
--- =================================

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
            return ('%s'):format(m:upper()):sub(1, 3)
        end,
        name = 'mode',
        default = ' UNK ',
        event = { 'ModeChanged', 'BufEnter', 'TermLeave' },
    }
end

function p.fileinfo()
    return {
        stl = function()
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local exclude = {
                'toggleterm',
            }

            if vim.tbl_contains(exclude, buf_ft) then
                return ''
            else
                return ('%s'):format([[%t]])
            end
        end,
        name = 'fileinfo',
        event = { 'BufEnter' },
        attr = {
            fg = colors.magenta,
        }
    }
end

function p.filetype()
    return {
        stl = function()
            local alias = { cpp = 'C++' }
            local ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })

            local res = ft:sub(1, 1):upper()
            if #ft ~= 1 then
                res = alias[ft] and alias[ft] or res .. ft:sub(2, #ft)
            end

            return res and ('[%s]'):format(res) or res
        end,
        name = 'filetype',
        event = { 'BufEnter' },
        attr = {
            fg = colors.cyan
        }
    }
end

function p.modified()
    return {
        name = 'modified',
        stl = function()
            return '%{&modified?"[+]":""}'
        end,
        event = { 'BufModifiedSet' },
        attr = {
            fg = colors.orange
        },
    }
end

function p.readonly()
    return {
        name = 'readonly',
        stl = function()
            return '%{&readonly?"[-]":""}'
        end,
        event = { 'BufEnter' },
        attr = {
            fg = colors.red
        },
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
                    msg = ('[%s]'):format(client.name)
                else
                    msg = ('%s %s%s'):format(
                        val.title,
                        (val.message and val.message .. ' ' or ''),
                        (val.percentage and val.percentage .. '%' or '')
                    )
                end
            elseif args.event == 'BufEnter' or args.event == 'LspAttach' then
                msg = ('[%s]'):format(client.name)
            elseif args.event == 'LspDetach' then
                msg = ''
            end
            return msg
        end,
        name = 'LSP',
        event = { 'LspProgress', 'LspAttach', 'LspDetach', 'BufEnter' },
        attr = {
            fg = colors.white
        }
    }
end

function p.git()
    return {
        stl = function()
            return coroutine.create(function(pieces, idx)
                local ok, head = pcall(vim.api.nvim_buf_get_var, 0, 'gitsigns_head')
                if not ok then
                    return ''
                end
                if head == '' then
                    local co = coroutine.running()
                    vim.system(
                        { 'git', 'config', '--get', 'init.defaultBranch' },
                        { text = true },
                        function(result)
                            coroutine.resume(co, #result.stdout > 0 and vim.trim(result.stdout) or nil)
                        end
                    )
                    head = coroutine.yield()
                end
                local parts = head
                if parts ~= "" and parts ~= nil then
                    parts = ("Git:%s"):format(parts)
                end
                pieces[idx] = utils.stl_format('git', parts)
            end)
        end,
        async = true,
        name = 'git',
        event = { 'User GitSignsUpdate', 'BufEnter' },
        attr = {
            fg = colors.blue
        }
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
                if count ~= 0 then
                    t[#t + 1] = utils.stl_format(vim.diagnostic.severity[i], count)
                end
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

function p.location()
    return {
        stl = function()
            return '%P (%-2.(%l:%c%))'
        end,
        name = 'location',
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
