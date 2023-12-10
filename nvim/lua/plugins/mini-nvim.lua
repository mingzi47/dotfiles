-- surround
local mini_surround = {
    custom_surroundings = nil,
    highlight_duration = 500,
    mappings = {
        add = 'sa',            -- Add surrounding in Normal and Visual modes
        delete = 'sd',         -- Delete surrounding
        find = 'sf',           -- Find surrounding (to the right)
        find_left = 'sF',      -- Find surrounding (to the left)
        highlight = 'sh',      -- Highlight surrounding
        replace = 'sr',        -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
        suffix_last = 'l',     -- Suffix to search with "prev" method
        suffix_next = 'n',     -- Suffix to search with "next" method
    },
    n_lines = 20,
    respect_selection_type = false,
    search_method = 'cover',
    silent = false,
}

-- pairs
local mini_pairs = {
    modes = { insert = true, command = false, terminal = false },
    mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
    },
}

-- comment
local mini_comment = {
    options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
    },
    mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        comment_visual = 'gc',
        textobject = 'gc',
    },
    hooks = {
        pre = function() end,
        post = function() end,
    },
}

-- a, i
local mini_ai = {
    custom_textobjects = nil,
    mappings = {
        around = 'a',
        inside = 'i',

        around_next = 'an',
        inside_next = 'in',
        around_last = 'al',
        inside_last = 'il',

        goto_left = 'g[',
        goto_right = 'g]',
    },
    n_lines = 500,
    search_method = 'cover_or_next',
    silent = false,
}

local mini_indentscope = {
    draw = {
        delay = 100,
        priority = 2,
    },

    mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '[i',
        goto_bottom = ']i',
    },

    options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = false,
    },

    symbol = '╎',
}


local M = {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        require("mini.surround").setup(mini_surround)
        require("mini.pairs").setup(mini_pairs)
        require("mini.comment").setup(mini_comment)
        require("mini.ai").setup(mini_ai)
        require("mini.cursorword").setup()
        require("mini.indentscope").setup(mini_indentscope)

        require("mini.tabline").setup()

        require("mini.doc").setup()
    end
}

return M
