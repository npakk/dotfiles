-- fix highlight
require'hop'.setup {
  create_hl_autocmd = true
}

vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>HopWord<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>HopChar1<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<leader>s', '<cmd>HopChar1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>HopLine<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<leader>l', '<cmd>HopLine<CR>', { noremap = true, silent = true })
