local s = require'snippets'
local u = require'snippets.utils'
s.snippets = {
  ruby = {
    require = u.match_indentation('require \'$0\''),
    class = u.match_indentation('class $0\nend'),
    module = u.match_indentation('module $0\nend'),
    def = u.match_indentation('def $0\nend'),
    ["do"] = u.match_indentation('do $0\nend'),
  }
}

vim.api.nvim_set_keymap('i', '<C-j>', '<cmd>lua return require"snippets".advance_snippet(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua return require"snippets".expand_or_advance(1)<CR>', { noremap = true, silent = true })
