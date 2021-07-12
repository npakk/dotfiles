--[[ Packer installation check ]]

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

--[[ Commands ]]

-- configfile auto compile
vim.cmd[[autocmd BufWritePost packer.lua PackerCompile]]

-- packadd packer when needed
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins.packer').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins.packer').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins.packer').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins.packer').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins.packer').compile()]]

--[[ Plugins ]]

require 'plugins.packer'
