vim.loader.enable()

--[[ Commands ]]

vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

vim.cmd([[command CD cd %:h]]) -- cd cwd

--[[ Settings ]]

vim.cmd("lan en_US.UTF-8")

vim.cmd([[filetype off]])
vim.cmd([[syntax off]])

require("core.options")
require("core.keymaps")
require("core.lazy")

vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax on]])
