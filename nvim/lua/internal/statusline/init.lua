local p, hl = require("internal.statusline.provider"), vim.api.nvim_set_hl

local utils = require("internal.statusline.utils")

local function default()
    local comps = {
        p.sep_spacewhite(),
        p.mode(),
        p.sep_spacewhite(),
        p.gitinfo(),
        p.sep_spacewhite(),
        p.diagnostic(),
        p.sep_spacewhite(),
        p.location(),
        '%=',
        p.fileinfo(),
        p.modified(),
        p.readonly(),
        '%=',
        '%S ',
        p.progress(),
        p.lsp(),
        p.sep_spacewhite(),
        p.encoding(),
        p.sep_spacewhite(),
        p.filesize(),
        p.sep_spacewhite(),
    }


    local e, pieces = {}, {}

    vim.iter(ipairs(comps)):map(function(key, item)
        if type(item) == 'string' then
            pieces[#pieces + 1] = utils.stl_format('Padding', item)
        else
            pieces[#pieces + 1] = item.default and utils.stl_format(item.name, item.default) or ''
            for _, event in ipairs({ unpack(item.event or {}) }) do
                e[event] = e[event] or {}
                e[event][#e[event] + 1] = key
            end
        end

        if item.attr and item.name then
            hl(0, ('StatusLine%s'):format(item.name), item.attr)
        end
    end):totable()

    return comps, e, pieces
end


local function render(comps, events, pieces)
    return coroutine.create(function(args)
        while true do
            local event = args.event == 'User' and ('%s %s'):format(args.event, args.match) or args.event
            for _, idx in ipairs(events[event]) do
                if comps[idx].async then
                    local child = comps[idx].stl()
                    coroutine.resume(child, pieces, idx)
                else
                    pieces[idx] = utils.stl_format(comps[idx].name, comps[idx].stl(args))
                end
            end

            vim.opt.stl = table.concat(pieces)
            args = coroutine.yield()
        end
    end)
end


return {
    setup = function()
        local comps, events, pieces = default()
        local stl_render = render(comps, events, pieces)

        vim.iter(vim.tbl_keys(events)):map(function(e)
            local tmp = e
            local pattern
            if e:find('User') then
                pattern = vim.split(e, '%s')[2]
                tmp = 'User'
            end

            vim.api.nvim_create_autocmd(tmp, {
                pattern = pattern,
                callback = function(args)
                    vim.schedule(function()
                        local ok, res = coroutine.resume(stl_render, args)

                        if not ok then
                            vim.notify('[StatusLine] render failed: ' .. res, vim.log.levels.ERROR)
                        end
                    end)
                end,
                desc = '[StatusLine] update'
            })
        end)
    end,
}
