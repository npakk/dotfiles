vim.g.mapleader = " "

-- ignore word-wrap
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true, silent = true })

-- Move to start/end of line
vim.api.nvim_set_keymap('n', '<S-h>', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', 'g_', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-h>', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-l>', 'g_', { noremap = true, silent = true })

-- Paste multiple times
-- https://kaminora.hatenablog.com/entry/2018/04/08/193154
vim.api.nvim_set_keymap('x', 'p', '"_dP', { noremap = true, silent = true })

-- Clear Search highlight
vim.api.nvim_set_keymap('n', '<ESC><ESC>', '<cmd>noh<CR>', { noremap = true, silent = true })

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true })

-- window create
vim.api.nvim_set_keymap('n', '<C-a>', '<C-w>v', { silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', '<C-w>s', { silent = true })

-- window close
vim.api.nvim_set_keymap('n', '<C-q>', '<C-w>c', { silent = true })

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- I hate escape
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent =true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent =true })

-- Move selected line
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv', { noremap = true, silent = true })

-- Completion by TAB
-- https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md#vimapinvim_replace_termcodes
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab(arg)
  if arg == 0 then
    return vim.fn.pumvisible() == 1 and t("<Down>") or t("<TAB>")
  else
    return vim.fn.pumvisible() == 1 and t("<Up>") or t("<S-TAB>")
  end
end
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab(0)', {expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_tab(1)', {expr = true, noremap = true, silent = true })
