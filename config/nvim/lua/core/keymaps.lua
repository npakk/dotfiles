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

local opts = { noremap = true, silent = true }

-- ignore word-wrap
vim.keymap.set("n", "gj", "j", opts)
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "gk", "k", opts)
vim.keymap.set("n", "k", "gk", opts)

-- Move to start/end of line
vim.keymap.set("n", "<S-h>", "^", opts)
vim.keymap.set("n", "<S-l>", "g_", opts)
vim.keymap.set("v", "<S-h>", "^", opts)
vim.keymap.set("v", "<S-l>", "g_", opts)

-- Paste multiple times
vim.keymap.set("x", "p", "pgvy", opts)

-- Clear Search highlight
vim.keymap.set("n", "<ESC><ESC>", "<cmd>noh<CR>", opts)

-- window close
vim.keymap.set("n", "<C-q>", "<C-w>c", opts)

-- better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- add line not insert
vim.keymap.set("n", "go", "o<ESC>", opts)
vim.keymap.set("n", "gO", "O<ESC>", opts)

-- I hate escape
vim.keymap.set("i", "jj", "<ESC>", opts)

-- Move selected line
vim.keymap.set("x", "J", ":move '>+1<CR>gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv", opts)

-- Confirm quit
vim.keymap.set("n", "<leader>q", "<cmd>confirm qa<CR>", { noremap = true, silent = true, desc = "Confirm Quit" })

-- Backspace
vim.keymap.set("i", "<C-h>", "<BS>", opts)

-- Delete
vim.keymap.set("i", "<C-d>", "<Delete>", opts)
