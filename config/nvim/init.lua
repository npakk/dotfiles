-- TODO: UTF-8 issue
-- check this: https://github.com/neovim/neovim/issues/14542

--[[ Provider ]]

-- Python2
if vim.fn.executable(vim.env.PYENV_ROOT .. "/versions/py2/bin/python") == 1 then
  vim.g.python_host_prog = vim.env.PYENV_ROOT .. "/versions/py2/bin/python"
else
  vim.g.loaded_python_provider = 0
end

-- Python3
if vim.fn.executable(vim.env.PYENV_ROOT .. "/versions/py3/bin/python") == 1 then
  vim.g.python3_host_prog = vim.env.PYENV_ROOT .. "/versions/py3/bin/python"
else
  vim.g.loaded_python3_provider = 0
end

-- Ruby
if vim.fn.executable(vim.env.RBENV_ROOT .. "/shims/neovim-ruby-host") == 1 then
  vim.g.ruby_host_prog = vim.env.RBENV_ROOT .. "/shims/neovim-ruby-host"
else
  vim.g.loaded_ruby_provider = 0
end

-- Node.js
if vim.fn.executable("/usr/local/bin/neovim-node-host") == 1 then
  vim.g.node_host_prog = "/usr/local/bin/neovim-node-host"
else
  vim.g.loaded_node_provider = 0
end

-- Perl
vim.g.loaded_perl_provider = 0

--[[ Commands ]]

-- TODO: Defining autocommands
-- check this: https://github.com/neovim/neovim/pull/12378
-- and this: https://github.com/neovim/neovim/pull/14661
vim.cmd([[
  augroup MyAutoCmd
  autocmd!
  augroup END
  augroup MyFormatAutoCmd
  autocmd!
  augroup END
]])

-- cd cwd
vim.cmd([[command CD cd %:h]])

--[[ Settings ]]

vim.cmd("lan en_US.UTF-8")

vim.cmd([[filetype off]])
vim.cmd([[syntax off]])

require("core.options")
require("core.mappings")
require("core.init")
require("core.appearances")

vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax on]])
