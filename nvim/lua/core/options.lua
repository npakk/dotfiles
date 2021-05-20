vim.o.termguicolors = true
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
vim.bo.swapfile = false
vim.bo.matchpairs = vim.bo.matchpairs .. ',<:>,「:」,『:』,（:）,【:】,《:》,〈:〉,［:］,‘:’,“:”'

vim.cmd('set viminfo+=n~/.cache/nvim/.viminfo')
