--[[ vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.encoding = 'utf-8'
vim.o.backup = false
vim.o.title = true
vim.o.hidden = true
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.hlsearch = true
vim.o.whichwrap = 'b,s,h,l,<,>,[,],~'
vim.o.completeopt = 'menuone,noinsert'
vim.o.wildmode = 'list,full'

if vim.fn.has('unix') == 1 then
  vim.o.clipboard = "unnamedplus"
else
  vim.o.clipboard = "unnamed"
end

vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.cursorline = true
vim.wo.list = true
vim.o.listchars = 'tab:| ,trail:･,eol:↲,extends:»,precedes:«,nbsp:%'
vim.wo.signcolumn = 'auto'

vim.o.nrformats = 'unsigned'
vim.bo.nrformats = 'unsigned'
vim.o.tabstop = 2
vim.o.softtabstop = -1
vim.o.shiftwidth = 0
vim.bo.softtabstop = -1
vim.bo.shiftwidth = 0
vim.cmd('set expandtab') -- issue https://github.com/neovim/neovim/issues/12978
vim.o.autoindent = true
vim.o.smartindent = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.swapfile = false
vim.bo.swapfile = false
vim.o.matchpairs = vim.o.matchpairs .. ',<:>,「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”'
vim.bo.matchpairs = vim.bo.matchpairs .. ',<:>,「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”'

vim.cmd('set viminfo+=n~/.cache/nvim/.viminfo') ]]

vim.cmd([[
set termguicolors
set background=dark
set encoding=utf-8
set nobackup
set title
set hidden
set showmatch
set matchtime=1
set hlsearch
set whichwrap=b,s,h,l,<,>,[,],~
set completeopt=menuone,noinsert
set wildmode=list,full
set clipboard=unnamed
set number
set norelativenumber
set cursorline
set list
set listchars=tab:\|\ ,trail:･,eol:↲,extends:»,precedes:«,nbsp:%
set signcolumn=auto
set nrformats=unsigned
set tabstop=2
set softtabstop=-1
set shiftwidth=0
set expandtab
set autoindent
set smartindent
set noswapfile
set matchpairs+=<:>,「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”
set viminfo+=n~/.cache/nvim/.viminfo
]])
