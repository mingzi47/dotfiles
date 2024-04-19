local M = {
    'akinsho/bufferline.nvim',
    event = "UIEnter",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { "[b",         "<Cmd>BufferLineCyclePrev<CR>",    desc = "Buffer : Prev [B]uffer" },
        { "]b",         "<Cmd>BufferLineCycleNext<CR>",    desc = "Buffer : Next [B]uffer" },
        { "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer : [B]uffer [1]" },
        { "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer : [B]uffer [2]" },
        { "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer : [B]uffer [3]" },
        { "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer : [B]uffer [4]" },
        { "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer : [B]uffer [5]" },
        { "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Buffer : [B]uffer [6]" },
        { "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Buffer : [B]uffer [7]" },
        { "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Buffer : [B]uffer [8]" },
        { "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Buffer : [B]uffer [9]" },
    },
}

M.config = function()
    require "bufferline".setup(
        {
            options = {
                mode = "buffers", -- tabs
                numbers = "ordinal",
                indicator = {
                    icon = '▎',
                    style = 'icon',
                },
                modified_icon = '●',
                left_trunc_marker = '',
                right_trunc_marker = '',
                tab_size = 12,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true
                    }
                },
                color_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                separator_style = "thin",
            },
        }
    )
end
return M
