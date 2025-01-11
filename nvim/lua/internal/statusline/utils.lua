local colors = require("utils.colors")
local M = {}

M.mode_alias = {
    --Normal
    ['n'] = 'Normal',
    ['no'] = 'O-Pending',
    ['nov'] = 'O-Pending',
    ['noV'] = 'O-Pending',
    ['no\x16'] = 'O-Pending',
    ['niI'] = 'Normal',
    ['niR'] = 'Normal',
    ['niV'] = 'Normal',
    ['nt'] = 'Normal',
    ['ntT'] = 'Normal',
    ['v'] = 'Visual',
    ['vs'] = 'Visual',
    ['V'] = 'V-Line',
    ['Vs'] = 'V-Line',
    ['\x16'] = 'V-Block',
    ['\x16s'] = 'V-Block',
    ['s'] = 'Select',
    ['S'] = 'S-Line',
    ['\x13'] = 'S-Block',
    ['i'] = 'Insert',
    ['ic'] = 'Insert',
    ['ix'] = 'Insert',
    ['R'] = 'Replace',
    ['Rc'] = 'Replace',
    ['Rx'] = 'Replace',
    ['Rv'] = 'V-Replace',
    ['Rvc'] = 'V-Replace',
    ['Rvx'] = 'V-Replace',
    ['c'] = 'Command',
    ['cv'] = 'Ex',
    ['ce'] = 'Ex',
    ['r'] = 'Replace',
    ['rm'] = 'More',
    ['r?'] = 'Confirm',
    ['!'] = 'Shell',
    ['t'] = 'Terminal',
}

M.mode_colors = {
    ['Normal'] = colors.red,
    ['Insert'] = colors.green,
    ['O-Pending'] = colors.red,
    ['Visual'] = colors.blue,
    ['V-Line'] = colors.blue,
    ['V-Block'] = colors.blue,
    ['Select'] = colors.blue,
    ['S-Line'] = colors.blue,
    ['S-Block'] = colors.blue,
    ['Replace'] = colors.violet,
    ['V-Replace'] = colors.violet,
    ['Command'] = colors.magenta,
    ['More'] = colors.cyan,
    ['Confirm'] = colors.cyan,
    ['Terminal'] = colors.red,
    ['Shell'] = colors.red,
}

function M.stl_bg()
    return vim.api.nvim_get_hl(0, { name = 'StatusLine' }).bg or 'black'
end

function M.stl_attr(group)
    local color = vim.api.nvim_get_hl(0, { name = group, link = false })
    return {
        bg = M.stl_bg(),
        fg = color.fg,
    }
end

function M.group_fmt(prefix, name, val)
    return ('%%#StatusLine%s%s#%s%%*'):format(prefix, name, val)
end

function M.stl_format(name, val)
    return ('%%#StatusLine%s#%s%%*'):format(name, val)
end
return M
