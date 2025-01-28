local map = vim.keymap.set

map("n", "<leader>hm", function ()
    require("internal.tools.messages").messages()
end, { desc = "Messages History" })
