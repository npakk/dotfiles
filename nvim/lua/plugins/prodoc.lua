vim.api.nvim_set_keymap('n', 'gcj', ':ProDoc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gcc', ':ProComment<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'gcc', ':ProComment<CR>', { noremap = true, silent = true })
