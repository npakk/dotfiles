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

local k = require("astronauta.keymap")
local nnoremap = k.nnoremap
local inoremap = k.inoremap
local vnoremap = k.vnoremap
local xnoremap = k.xnoremap
local nmap = k.nmap

-- ignore word-wrap
nnoremap({ "j", "gj", { silent = true } })
nnoremap({ "gj", "j", { silent = true } })
nnoremap({ "k", "gk", { silent = true } })
nnoremap({ "gk", "k", { silent = true } })

-- Move to start/end of line
nnoremap({ "<S-h>", "^", { silent = true } })
nnoremap({ "<S-l>", "g_", { silent = true } })
vnoremap({ "<S-h>", "^", { silent = true } })
vnoremap({ "<S-l>", "g_", { silent = true } })

-- Enhancement Delete
inoremap({ "<C-l>", "<Delete>", { silent = true } })

-- Paste multiple times
-- https://stackoverflow.com/questions/7163947/paste-multiple-times
xnoremap({ "p", "pgvy", { silent = true } })

-- Clear Search highlight
nnoremap({ "<ESC><ESC>", ":noh<CR>", { silent = true } })

-- better window movement
nmap({ "<C-h>", "<C-w>h", { silent = true } })
nmap({ "<C-j>", "<C-w>j", { silent = true } })
nmap({ "<C-k>", "<C-w>k", { silent = true } })
nmap({ "<C-l>", "<C-w>l", { silent = true } })

-- window create
nmap({ "<C-a>", "<C-w>v", { silent = true } })
nmap({ "<C-s>", "<C-w>s", { silent = true } })

-- window close
nmap({ "<C-q>", "<C-w>c", { silent = true } })

-- better indenting
vnoremap({ "<", "<gv", { silent = true } })
vnoremap({ ">", ">gv", { silent = true } })

-- add line not insert
nnoremap({ "go", "o<ESC>", { silent = true } })
nnoremap({ "gO", "O<ESC>", { silent = true } })

-- I hate escape
inoremap({ "jj", "<ESC>", { silent = true } })

-- Move selected line
xnoremap({ "J", ":move '>+1<CR>gv", { silent = true } })
xnoremap({ "K", ":move '<-2<CR>gv", { silent = true } })
