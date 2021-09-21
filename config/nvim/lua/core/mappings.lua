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

local api = vim.api
local kopts = { noremap = true, silent = true }

-- ignore word-wrap
api.nvim_set_keymap("n", "gj", "j", kopts)
api.nvim_set_keymap("n", "j", "gj", kopts)
api.nvim_set_keymap("n", "gk", "k", kopts)
api.nvim_set_keymap("n", "k", "gk", kopts)

-- Move to start/end of line
api.nvim_set_keymap("n", "<S-h>", "^", kopts)
api.nvim_set_keymap("n", "<S-l>", "g_", kopts)
api.nvim_set_keymap("v", "<S-h>", "^", kopts)
api.nvim_set_keymap("v", "<S-l>", "g_", kopts)

-- Paste multiple times
-- https://stackoverflow.com/questions/7163947/paste-multiple-times
api.nvim_set_keymap("x", "p", "pgvy", kopts)

-- Clear Search highlight
api.nvim_set_keymap("n", "<ESC><ESC>", ":noh<CR>", kopts)

-- better window movement
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { silent = true })
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { silent = true })
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { silent = true })
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- window create
api.nvim_set_keymap("n", "<C-g>", "<C-w>v", { silent = true })
api.nvim_set_keymap("n", "<C-s>", "<C-w>s", { silent = true })

-- window close
api.nvim_set_keymap("n", "<C-q>", "<C-w>c", { silent = true })

-- better indenting
api.nvim_set_keymap("v", "<", "<gv", kopts)
api.nvim_set_keymap("v", ">", ">gv", kopts)

-- add line not insert
api.nvim_set_keymap("n", "go", "o<ESC>", kopts)
api.nvim_set_keymap("n", "gO", "O<ESC>", kopts)

-- I hate escape
api.nvim_set_keymap("i", "jj", "<ESC>", kopts)

-- Move selected line
api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv", kopts)
api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv", kopts)

-- Confirm quit
api.nvim_set_keymap("n", "<leader>q", ":confirm qa<CR>", kopts)

-- Backspace
api.nvim_set_keymap("i", "<C-h>", "<BS>", { silent = true })

-- Delete
api.nvim_set_keymap("i", "<C-d>", "<Delete>", kopts)
