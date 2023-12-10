return {
    {
        "folke/which-key.nvim",
        lazy = true,
        event = 'VeryLazy',
        config = function()
            local wk = require("which-key")

            wk.setup({
                {
                    plugins = { spelling = true },
                }
            })

            wk.register({
                ["<leader><tab>"] = { name = "+[Tab]" },
                ["<leader>b"] = { name = "+[B]uffers" },
                ["<leader>f"] = { name = "+[F]ind" },
                ["<leader>g"] = { name = "+[G]it" },
                ["<leader>l"] = { name = "+[L]sp" },
                ["<leader>a"] = { name = "+[A]ction" },
                ["<leader>p"] = { name = "+[P]ane" },
            })

            wk.setup({
                window = {
                    border = "double",
                    position = "bottom",
                    padding = { 1, 2, 1, 2 },
                    zindex = 1000,
                },
                layout = {
                    height = { min = 4, max = 25 },
                    width = { min = 2, max = 50 },
                    spacing = 3,
                    align = "left",
                }
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { text = '▎' },
                    change = { text = '▎' },
                    delete = { text = '➤' },
                    topdelete = { text = '➤' },
                    changedelete = { text = '▎' },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    -- Navigation
                    map('n', ']g', function()
                        if vim.wo.diff then return ']g' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Git: Next [G]it hunk" })

                    map('n', '[g', function()
                        if vim.wo.diff then return '[g' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Git: Prev [G]it hunk" })

                    map('n', '<leader>gs', gs.stage_hunk, { desc = "Git: [G]it [S]tage" })
                    map('n', '<leader>gr', gs.reset_hunk, { desc = "Git: [G]it [R]eset" })
                    map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                        { desc = "Git: [G]it [S]tage(Save)" })
                    map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
                        { desc = "Git: [G]it [R]eset(Recover)" })
                    map('n', '<leader>gS', gs.stage_buffer, { desc = "Git: [G]it [S]tage buffer" })
                    -- map('n', '<leader>gu', gs.undo_stage_hunk, {desc = ""})
                    map('n', '<leader>gR', gs.reset_buffer, { desc = "Git: [G]it [R]eset buffer" })
                    map('n', '<leader>gp', gs.preview_hunk, { desc = "Git: [G]it [P]review" })
                    map('n', '<leader>gb', function() gs.blame_line { full = true } end,
                        { desc = "Git: [G]it [B]lame commits" })
                    map('n', '<leader>gl', gs.toggle_current_line_blame, { desc = "Git: [G]it [L]ine commit" })
                    map('n', '<leader>gd', gs.diffthis, { desc = "Git: [G]it [D]iff file" })
                    map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Git: [G]it [D]iff file(all line)" })
                    map('n', '<leader>gt', gs.toggle_deleted, { desc = "Git: [G]it Show deleted" })
                end
            })
        end
    },
    {
        "nvim-telescope/telescope.nvim", -- npm install fd ripgrep
        lazy = true,
        keys = {
            { "<leader>ff", "<cmd> Telescope find_files<CR>", desc = "Telescope: [F]ind [F]ile" },
            { "<leader>fb", "<cmd> Telescope buffers<CR>",    desc = "Telescope: [F]ind [B]uffer" },
            { "<leader>fw", "<cmd> Telescope live_grep<CR>",  desc = "Telescope: [F]ind [W]ord" },
            { "<leader>fg", "<cmd> Telescope git_status<CR>", desc = "Telescope: [F]ind [G]it_status" },
            -- { "<leader>fn", "<cmd> Noice telescope <CR>",     desc = "Telescope: [F]ind [N]oice" },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    color_devicons = true,
                    file_ignore_patterns = { "node_modules", "build", ".git", ".vscode", "bin" },
                    initial_mode = "normal",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.75,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.95,
                        height = 0.95,
                        preview_cutoff = 120,
                    },
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                            ["d"] = require("telescope.actions").delete_buffer,
                            ["s"] = require("telescope.actions").file_split,
                            ["v"] = require("telescope.actions").file_vsplit,
                        },
                    },
                },
            })
        end,
        dependencies =
        { "nvim-lua/plenary.nvim" }
    },
    {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {
            import = {
                vscode = true,
                nlsp = true,
            },
        }
    },
    {
        "DreamMaoMao/yazi.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { "<leader>e", "<cmd>Yazi<CR>", desc = "File Explorer: [E]xplorer Yazi" },
        },
    }
}
