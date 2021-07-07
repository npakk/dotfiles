vim.cmd[[let theme = 'blue-moon' | execute 'packadd ' . theme | execute 'colorscheme ' . theme]]
vim.cmd[[autocmd MyAutoCmd VimEnter * nested hi Whitespace guifg=#676e96 guibg=NONE]]
vim.cmd[[autocmd MyAutoCmd VimEnter * nested hi CursorLine gui=underline cterm=underline guibg=NONE]]
