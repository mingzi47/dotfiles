local M = {}

function M.messages()
    -- 获取消息历史（带颜色代码）
    local messages = vim.split(vim.fn.execute('messages'), '\n')

    -- 过滤空行并反转顺序（最新消息在最后）
    messages = vim.tbl_filter(function(line)
        return line:match("%S") and not line:match("^%s*$")
    end, messages)

    -- 创建零食窗口实例
    local win = Snacks.win({
        title = "Messages",
        title_pos = "center",
        position = "float",
        border = "rounded",
        wo = {
            number = true,     -- 显示绝对行号
            -- relativenumber = true, -- 显示相对行号（可选）
            numberwidth = 4,   -- 行号列宽度
            -- signcolumn = "yes", -- 保持符号列
            cursorline = true, -- 高亮当前行（可选）
        },
        -- width = 0.8,
        -- height = 0.7,
        ft = "messages",
        text = messages,
        on_buf = function(self)
            -- 设置缓冲区选项
            vim.bo[self.buf].modifiable = false
            vim.bo[self.buf].readonly = true
            vim.bo[self.buf].bufhidden = "wipe"

        end,
    })

    win:map()
end

return M
