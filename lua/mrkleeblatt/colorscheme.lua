-- local colorscheme = 'monokai_pro'
-- local colorscheme = 'retrobox'
-- local colorscheme = 'slate'
-- local colorscheme = 'tokyonight-night'
local colorscheme = 'wildcharm'
-- local colorscheme = 'sorbet'
-- local colorscheme = 'habamax'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
