-- packer installation check
local data_home
if vim.fn.empty(vim.env.XDG_DATA_HOME) == true then
  data_home = vim.fn.expand('~/.local/share')
else
  data_home = vim.env.XDG_DATA_HOME
end

local packer_dir = data_home..'/nvim/site/pack/packer/opt/packer.nvim'

if not string.find(vim.o.runtimepath, '/packer.nvim') then
  if not (vim.fn.isdirectory(packer_dir) == 1) then
    os.execute('git clone https://github.com/wbthomason/packer.nvim '..packer_dir)
  end
  vim.o.runtimepath = packer_dir..','..vim.o.runtimepath
end

-- configfile auto compile
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

-- packadd packer when needed
vim.cmd[[command! PackerInstall packadd packer.nvim | lua require('plugins.plugins').install()]]
vim.cmd[[command! PackerUpdate packadd packer.nvim | lua require('plugins.plugins').update()]]
vim.cmd[[command! PackerSync packadd packer.nvim | lua require('plugins.plugins').sync()]]
vim.cmd[[command! PackerClean packadd packer.nvim | lua require('plugins.plugins').clean()]]
vim.cmd[[command! PackerCompile packadd packer.nvim | lua require('plugins.plugins').compile()]]

require 'plugins.plugins'
