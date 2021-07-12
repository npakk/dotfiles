vim.cmd [[execute 'packadd ' . 'lush.nvim']]
vim.cmd [[execute 'packadd ' . 'gruvbox.nvim']]

--[[ colorscheme ]]

vim.cmd [[execute 'colorscheme ' . 'gruvbox']]
--[[ require('material').set()
vim.g.material_style = 'darker' ]]

-- blue-moon
-- vim.cmd [[autocmd MyAutoCmd VimEnter * nested hi Whitespace guifg=#676e96 guibg=NONE]]

--[[ colorbuddy ]]

-- vim.cmd [[packadd colorbuddy.vim]]

-- gruvbuddy
--[[ require('colorbuddy').colorscheme('gruvbuddy')
local Color = require('colorbuddy').Color
Color.new('yellow', '#e5d714') ]]

--[[ Redefine default highlight ]]

-- cursorline
-- vim.cmd [[autocmd MyAutoCmd VimEnter * nested hi CursorLine gui=underline cterm=underline guibg=NONE]]
