return {
  {
    'folke/trouble.nvim',
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>le", function() require("trouble").open("workspace_diagnostics") end, desc = "diagnostics list" },
      {
        "gr",
        function() require("trouble").open("lsp_references") end,
        desc = "lsp ref list"
      },
    },
    opts = {
      pasition = "bottom",
      height = 10,
      width = 50,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "o", "<cr>", "<2-leftmouse>" },
        open_split = { "s" },
        open_vsplit = { "v" },
        open_tab = { "<tab>" },
        jump_close = { "o" },
        toggle_mode = "m",
        switch_severity = "<c-s>",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        open_code_href = "c",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
        help = "?"
      },
      win_config = { border = "rounded" },
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    keys = {
      { "<leader>e", "<cmd> Neotree <cr>", desc = "Open Explore" }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = false,
        sort_function = nil,
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
        },
        window = {
          position = "left",
          width = 25,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = "",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["o"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["O"] = "close_node",
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              config = {
                show_path = "none"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            bind_to_cwd = false,
            follow_current_file = true,
            use_libuv_file_watcher = true,
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              "node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              ".DS_Store",
              "thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = false,
          group_empty_dirs = false,               -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          use_libuv_file_watcher = false,         -- This will use the OS level file watchers to detect changes
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          }
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          group_empty_dirs = true,    -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('lualine').setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          component_separators = { left = "\u{e0b5}", right = "\u{e0b7}" },
          section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
          globalstatus = true,
          refresh = {
            statusline = 100,
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(content, context)
                return ("\u{e7c5}%s"):format(content)
              end,
            },
          },
          lualine_b = {
            { "branch", icon = "\u{ea68}" },
          },
          lualine_c = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              sections = { 'error', 'warn', 'info', 'hint' },
              colors = {
                error = "#BF616A",
                warn = "#EBCB8B",
                info = "#A3BE8C",
                hint = "#88C0D0",
              },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            }
          },
          lualine_x = {
          },
          lualine_y = {
            { "filetype" },
            { "encoding" },
          },
          lualine_z = {
            {
              "progress",
              fmt = function(content, context)
                local visual_str = {
                  ["v"] = true,
                  ["V"] = true,
                  ["\22"] = true,
                }
                if visual_str[tostring(vim.fn.mode())] then
                  local ln_beg = vim.fn.line("v")
                  local ln_end = vim.fn.line(".")
                  -- local end = vim.fn.line("")
                  local lines = ln_beg <= ln_end and ln_end - ln_beg + 1 or ln_beg - ln_end + 1
                  return ("- %d -"):format(tostring(lines))
                end

                return ("\u{e612} %s"):format(content)
              end,
            },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    'akinsho/bufferline.nvim',
    lazy = true,
    event = 'VeryLazy',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local map = vim.keymap.set;
      map({ "n" }, "<leader>bd", "<cmd>BufferDelete<CR>", { silent = true, noremap = true, desc = "Delete buffer" })
      map({ "n" }, "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true, noremap = true, desc = "Next buffer" })
      map({ "n" }, "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { silent = true, noremap = true, desc = "Prev buffer" })
      require("bufferline").setup({
        options = {
          buffer_close_icon = '\u{f015a}',
          offsets = {
            {
              filetype = "neo-tree",
              text = "\u{e5fe}  Explorer",
              text_align = "center",
              separator = true
            },
            {
              filetype = "sagaoutline",
              text = "\u{f1e0}  Symbols",
              text_align = "center",
              separator = true
            }
          },
        }
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          require("notify").setup({
            background_colour = "#000000"
          })
        end
      },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      messages = {
        enabled = true,
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
        view_history = "popup",
        view_search = "virtualtext",
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = "UIEnter",
    config = function()
      require("indent_blankline").setup {
        char = ' ',
        context_char = '┆',
        context_highlight_list = {
          "IndentBlanklinePink"
        },
        show_current_context = true,
        show_current_context_start = false,

      }
    end,
  }
}
