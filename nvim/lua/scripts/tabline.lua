vim.cmd [[
  highlight TabLine      guifg=#999999 guibg=#222222 gui=none
  highlight TabLineSel   guifg=#ffffff guibg=#333333 gui=bold
  highlight TabLineFill  guifg=#999999 guibg=#222222 gui=none
]]

function _G.my_tabline()
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        if i == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        s = s .. '%' .. i .. 'T'  -- 鼠标点击事件
        s = s .. '  ' .. i .. '  '
    end
    s = s .. '%#TabLineFill#%T' -- 填充剩余空间
    return s
end

vim.o.tabline = '%!v:lua.my_tabline()'
