local u = require'snippets.utils'
require'snippets'.snippets = {
  ruby = {
    def = u.match_indentation('def $1\n  $0\nend')
  }
}

vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua return require"snippets".advance_snippet(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua return require"snippets".expand_or_advance(1)<CR>', { noremap = true, silent = true })
