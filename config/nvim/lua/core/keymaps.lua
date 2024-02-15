vim.g.mapleader = " "

--[[
-----------------------------------------------------------------------------
| Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
|------------------|--------|--------|---------|--------|--------|----------|
| map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
| nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
| vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
| omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
| xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
| smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
| map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
| imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
| cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
-----------------------------------------------------------------------------
--]]

local set_keymap = function(mode, key, rhs, options, _buffer)
  local opts = table.insert({ noremap = true, silent = true, buffer = _buffer }, options)
  vim.keymap.set(mode, key, rhs, opts)
end

-- ignore word-wrap
set_keymap("n", "gj", "j")
set_keymap("n", "j", "gj")
set_keymap("n", "gk", "k")
set_keymap("n", "k", "gk")

-- Move to start/end of line
set_keymap("n", "<S-h>", "^")
set_keymap("n", "<S-l>", "g_")
set_keymap("v", "<S-h>", "^")
set_keymap("v", "<S-l>", "g_")

-- Paste multiple times
set_keymap("x", "p", "pgvy")

-- Clear Search highlight
set_keymap("n", "<ESC><ESC>", "<cmd>noh<CR>")

-- window close
set_keymap("n", "<C-q>", "<C-w>c")

-- better indenting
set_keymap("v", "<", "<gv")
set_keymap("v", ">", ">gv")

-- add line not insert
set_keymap("n", "go", "o<ESC>")
set_keymap("n", "gO", "O<ESC>")

-- I hate escape
set_keymap("i", "jj", "<ESC>")

-- Move selected line
set_keymap("x", "J", ":move '>+1<CR>gv")
set_keymap("x", "K", ":move '<-2<CR>gv")

-- Confirm quit
set_keymap("n", "<leader>q", ":confirm qa<CR>")

-- Backspace
set_keymap("i", "<C-h>", "<BS>")

-- Delete
set_keymap("i", "<C-d>", "<Delete>")
