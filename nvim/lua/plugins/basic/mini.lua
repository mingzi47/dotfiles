local surround = {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
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
}

local pairs = {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {
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
}

local ai = {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {
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
}

local comment = {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {
        optsions = {
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
    }
}

local indentscope = {
    'echasnovski/mini.indentscope',
    event = 'UIEnter',
    opts = {
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
    },
    config = function()
        vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
    end
}

local cursorword = {
    'echasnovski/mini.cursorword',
    event = 'UIEnter',
    config = true,
}

local clue = {
    'echasnovski/mini.clue',
    event = 'VeryLazy',
    config = function()
        require('mini.clue').setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },

                -- `[` key
                { mode = 'n', keys = '[' },
                { mode = 'x', keys = '[' },

                -- `]` key
                { mode = 'n', keys = ']' },
                { mode = 'x', keys = ']' },
            },

            clues = {
                { mode = 'n', keys = '<Leader>b',     desc = '+Buffers' },
                { mode = 'n', keys = '<Leader>l',     desc = '+LSP' },
                { mode = 'n', keys = '<Leader>p',     desc = '+Pane' },
                { mode = 'n', keys = '<Leader>f',     desc = '+File' },
                { mode = 'n', keys = '<Leader>a',     desc = '+Action' },
                { mode = 'n', keys = '<Leader>s',     desc = '+Search' },
                { mode = 'n', keys = '<Leader>t',     desc = '+Term' },
                { mode = 'n', keys = '<Leader><TAB>', desc = '+Tab' },
                { mode = 'n', keys = '<Leader>w',     desc = '+Win' },

                require 'mini.clue'.gen_clues.builtin_completion(),
                require 'mini.clue'.gen_clues.g(),
                require 'mini.clue'.gen_clues.marks(),
                require 'mini.clue'.gen_clues.registers(),
                require 'mini.clue'.gen_clues.windows(),
                require 'mini.clue'.gen_clues.z(),
            },
            window = {
                -- Floating window config
                config = {},

                -- Delay before showing clue window
                delay = 100,

                -- Keys to scroll inside the clue window
                scroll_down = '<C-d>',
                scroll_up = '<C-u>',
            },
        })
    end
}

local session = {
    'echasnovski/mini.sessions',
    event = { 'VeryLazy' },
    config = function()
        require('mini.sessions').setup({
            autoread = false,
            autowrite = true,
            file = '',
            verbose = { read = true, write = true, delete = true },
        })
    end
}



return {
    surround,
    pairs,
    ai,
    comment,
    indentscope,
    cursorword,
    clue,
    session,
}
