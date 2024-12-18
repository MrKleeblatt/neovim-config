-- local colorscheme = 'default'
-- local colorscheme = 'monokai_pro'
local colorscheme = 'retrobox'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
