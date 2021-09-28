--[[ Packer installation check ]]

local data_home
if vim.fn.empty(vim.env.XDG_DATA_HOME) == true then
  data_home = vim.fn.expand("~/.local/share")
else
  data_home = vim.env.XDG_DATA_HOME
end

local packer_dir = data_home .. "/nvim/site/pack/packer/opt/packer.nvim"

if not string.find(vim.o.runtimepath, "/packer.nvim") then
  if not (vim.fn.isdirectory(packer_dir) == 1) then
    os.execute("git clone https://github.com/wbthomason/packer.nvim " .. packer_dir)
  end
  vim.o.runtimepath = packer_dir .. "," .. vim.o.runtimepath
end

--[[ Commands ]]

-- packadd packer when needed
vim.api.nvim_exec(
  [[
  autocmd BufWritePost packer.lua source <afile> | PackerCompile
  command! PackerInstall packadd packer.nvim | lua require("plugins.packer").install()
  command! PackerUpdate packadd packer.nvim | lua require("plugins.packer").update()
  command! PackerSync packadd packer.nvim | lua require("plugins.packer").sync()
  command! PackerClean packadd packer.nvim | lua require("plugins.packer").clean()
  command! PackerCompile packadd packer.nvim | lua require("plugins.packer").compile()
  ]],
  true
)

--[[ Packer ]]

require("plugins.packer")
