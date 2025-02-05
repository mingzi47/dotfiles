local map = vim.keymap.set

map("n", "<leader>hm", function ()
    require("internal.tools.messages").messages()
end, { desc = "Messages History" })



map({ "n", "t", "v", "x" }, "gf", function ()
    require("internal.tools.gf").gf()
end, { desc = "Goto file(URL)" })
