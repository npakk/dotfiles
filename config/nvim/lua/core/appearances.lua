-- colorscheme
vim.cmd([[
packadd lush.nvim
packadd gruvbox.nvim
colorscheme gruvbox
]])

-- clear spell highlight
vim.cmd([[
hi clear SpellBad
hi clear SpellCap
]])
