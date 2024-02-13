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

local kopts = { noremap = true, silent = true }

-- ignore word-wrap
vim.keymap.set("n", "gj", "j", kopts)
vim.keymap.set("n", "j", "gj", kopts)
vim.keymap.set("n", "gk", "k", kopts)
vim.keymap.set("n", "k", "gk", kopts)

-- Move to start/end of line
vim.keymap.set("n", "<S-h>", "^", kopts)
vim.keymap.set("n", "<S-l>", "g_", kopts)
vim.keymap.set("v", "<S-h>", "^", kopts)
vim.keymap.set("v", "<S-l>", "g_", kopts)

-- Paste multiple times
vim.keymap.set("x", "p", "pgvy", kopts)

-- Clear Search highlight
vim.keymap.set("n", "<ESC><ESC>", ":noh<CR>", kopts)

-- window close
vim.keymap.set("n", "<C-q>", "<C-w>c", kopts)

-- better indenting
vim.keymap.set("v", "<", "<gv", kopts)
vim.keymap.set("v", ">", ">gv", kopts)

-- add line not insert
vim.keymap.set("n", "go", "o<ESC>", kopts)
vim.keymap.set("n", "gO", "O<ESC>", kopts)

-- I hate escape
vim.keymap.set("i", "jj", "<ESC>", kopts)

-- Move selected line
vim.keymap.set("x", "J", ":move '>+1<CR>gv", kopts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv", kopts)

-- Confirm quit
vim.keymap.set("n", "<leader>q", ":confirm qa<CR>", kopts)

-- Backspace
vim.keymap.set("i", "<C-h>", "<BS>", kopts)

-- Delete
vim.keymap.set("i", "<C-d>", "<Delete>", kopts)
