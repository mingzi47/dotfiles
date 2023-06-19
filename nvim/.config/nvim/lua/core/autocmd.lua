-- Template
vim.api.nvim_create_user_command("CMakeTemplate", 
  '0r $HOME/.config/nvim/snippets/CMakeLists.txt', 
  { desc = "Create CMakeLists Template" }
)

-- 自动保存
vim.api.nvim_create_autocmd({ 'InsertLeave', "TextChanged" }, {
  pattern = { "*" },
  command = "silent! wall",
  nested = true,
})


-- 重新打开缓冲区恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos(".", vim.fn.getpos("'\""))
      vim.cmd("silent! foldopen")
    end
  end,
})

-- 关闭新行注释
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

-- 删除 buffer 保持窗口布局
vim.api.nvim_create_user_command("BufferDelete", function()
  ---@diagnostic disable-next-line: missing-parameter
  local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
  local modified = vim.api.nvim_buf_get_option(0, "modified")
  if file_exists == 0 and modified then
    local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
    if user_choice == "y" or string.len(user_choice) == 0 then
      vim.cmd("bd!")
    end
    return
  end
  local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
  vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })
