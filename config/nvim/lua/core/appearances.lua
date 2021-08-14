--vim.api.nvim_exec(
--  [[
--  packadd lush.nvim
--  packadd gruvbox.nvim
--  colorscheme gruvbox
--  ]],
--  true
--)
vim.api.nvim_exec(
  [[
  let g:nvcode_termcolors=256
  packadd nvcode-color-schemes.vim
  colorscheme nvcode
  ]],
  true
)
