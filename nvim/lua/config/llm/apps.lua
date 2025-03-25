local prompts = require("config.llm.prompts")
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
                -- args = [=[return string.format([[curl %s -N -X POST -H "Content-Type: application/json" -H "Authorization: Bearer %s" -d '%s']], url, LLM_KEY, vim.fn.json_encode(body))]=],
                -- args = [[return {url, "-N", "-X", "POST", "-H", "Content-Type: application/json", "-H", authorization, "-d", vim.fn.json_encode(body)}]],
                exit_on_move = true,
                enter_flexible_window = false,
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
            handler = tools.action_handler,
            opts = {
                language = "Chinese",
            },
        },
    }
}


return M
