-- colorscheme
vim.cmd([[
packadd gruvbox-material
let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_transparent_background = 1
colorscheme gruvbox-material
]])

-- clear spell highlight
vim.cmd([[
hi clear SpellBad
hi clear SpellCap
]])
