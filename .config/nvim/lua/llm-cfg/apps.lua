local prompts = require("llm-cfg.prompts")
local tools = require("llm.tools")


local M = {
    app_handler = {
        DocString = {
            prompts = prompts.DocString,
            handler = tools.action_handler,
            opts = {
                only_display_diff = true,
                templates = {
                    lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
                },
            },
        },

        CodeExplain = {
            handler = tools.flexi_handler,
            prompt = prompts.CodeExplain,
            opts = {
                enter_flexible_window = true,
            },
        },

        CommitMsg = {
            handler = tools.flexi_handler,
            prompt = prompts.CommitMsg,

            opts = {
                enter_flexible_window = true,
                apply_visual_selection = false,
                win_opts = {
                    relative = "editor",
                    position = "50%",
                    zindex = 100,
                },
                accept = {
                    mapping = {
                        mode = "n",
                        keys = "<cr>",
                    },
                    action = function()
                        local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
                        vim.api.nvim_command(string.format('!git commit -m "%s"', table.concat(contents, '" -m "')))

                        -- just for lazygit
                        -- vim.schedule(function()
                        --     vim.api.nvim_command("LazyGit")
                        -- end)
                    end,
                },
            },
        },

        WordTranslate = {
            handler = tools.flexi_handler,
            prompt = prompts.WordTranslate,
            opts = {
                win_opts = {
                    zindex = 120,
                },
                exit_on_move = false,
                enter_flexible_window = true,
            },
        },

        Translate = {
            handler = tools.qa_handler,
            opts = {
                component_width = "60%",
                component_height = "50%",
                query = {
                    title = " 󰊿 Trans ",
                    hl = { link = "Define" },
                },
                input_box_opts = {
                    size = "15%",
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
                preview_box_opts = {
                    size = "85%",
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
            },
        },

        TestCode = {
            handler = tools.side_by_side_handler,
            prompt = prompts.TestCode,
            opts = {
                right = {
                    title = " Test Cases ",
                },
            },
        },

        OptimCompare = {
            handler = tools.side_by_side_handler,
            opts = {
                language = "Chinese",
            },
        },
        AttachToChat = {
            handler = tools.attach_to_chat_handler,
            opts = {
                is_codeblock = true,
                inline_assistant = true,
                language = "Chinese",
            },
        },
    }
}


return M
