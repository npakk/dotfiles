local u = require'snippets.utils'

require'snippets'.snippets = {
  ruby = {
    require = u.match_indentation('require \'$1\'\n$0'),
    class = u.match_indentation('class $1\n  $0\nend'),
    module = u.match_indentation('module $1\n  $0\nend'),
    def = u.match_indentation('def $1\n  $0\nend'),
    ["do"] = u.match_indentation('do |$1|\n  $0\nend'),
  }
}

vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua return require"snippets".advance_snippet(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua return require"snippets".expand_or_advance(1)<CR>', { noremap = true, silent = true })
