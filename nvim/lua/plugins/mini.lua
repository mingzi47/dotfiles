local surround = {
    'echasnovski/mini.surround',
    version = '*',
    opts = {
        mappings = {
            add = 'sa',            -- Acommentdd surrounding in Normal and Visual modes
            delete = 'sd',         -- Delete surrounding
            find = 'sf',           -- Find surrounding (to the right)
            find_left = 'sF',      -- Find surrounding (to the left)
            highlight = 'sh',      -- Highlight surrounding
            replace = 'sr',        -- Replace surrounding
            update_n_lines = 'sn', -- Update `n_lines`

            suffix_last = 'l',     -- Suffix to search with "prev" method
            suffix_next = 'n',     -- Suffix to search with "next" method
        },
    },
    keys = {
        { "sa", "sa", mode = { "n", "v", "o" }, desc = "Add srround" },
        { "sd", "sd", mode = { "n", "v", "o" }, desc = "Delete surround" },
        { "sr", "sr", mode = { "n", "v", "o" }, desc = "Replace surround" },
        { "sf", "sf", mode = { "n", "v", "o" }, desc = "Find surround (to the right)" },
        { "sF", "sF", mode = { "n", "v", "o" }, desc = "Find surround (to the Left)" },
        { "sn", "sn", mode = { "n", "v", "o" }, desc = "Update 'n_lines'" },
    }
}

return {
    surround,
}
