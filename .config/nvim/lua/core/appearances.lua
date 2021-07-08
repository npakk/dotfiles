vim.cmd[[execute 'packadd ' . 'gruvbuddy.nvim']]
vim.cmd[[execute 'colorscheme ' . 'gruvbuddy']]

--[ colorscheme ]
-- blue-moon
--vim.cmd[[autocmd MyAutoCmd VimEnter * nested hi Whitespace guifg=#676e96 guibg=NONE]]

--[ colorbuddy theme ]
vim.cmd('packadd colorbuddy.vim')

-- gruvbuddy
require('colorbuddy').colorscheme('gruvbuddy')
local Color = require('colorbuddy').Color
Color.new('yellow', '#e5d714')

--[ custom cursor underline ]
vim.cmd[[autocmd MyAutoCmd VimEnter * nested hi CursorLine gui=underline cterm=underline guibg=NONE]]
