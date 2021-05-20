local api = vim.api
local fn = vim.fn
local env = vim.env
local o = vim.o

--api.nvim_set_var('dein#auto_recache', 1)
api.nvim_set_var('dein#lazy_rplugins', 1)
api.nvim_set_var('dein#enable_notification', 1)
api.nvim_set_var('dein#install_github_api_token', os.getenv('GITHUB_TOKEN'))
api.nvim_set_var('dein#install_max_processes', 16)
api.nvim_set_var('dein#install_message_type', 'none')

local cache_home
if fn.empty(env.XDG_CACHE_HOME) == true then
  cache_home = fn.expand('~/.cache') 
else
  cache_home = env.XDG_CACHE_HOME
end

local config_home
if fn.empty(env.XDG_CONFIG_HOME) == true then
  config_home = fn.expand('~/.config') 
else
  config_home = env.XDG_CONFIG_HOME
end

local dein_dir = cache_home..'/dein'
local dein_repo_dir = dein_dir..'/repos/github.com/Shougo/dein.vim'

-- dein installation check
if not string.find(o.runtimepath, '/dein.vim') then
  if not (fn.isdirectory(dein_repo_dir) == 1) then
    os.execute('git clone https://github.com/Shougo/dein.vim '..dein_repo_dir)
  end
  o.runtimepath = dein_repo_dir..','..o.runtimepath
end

-- dein settings
if (fn['dein#load_state'](dein_dir) == 1) then
  local rc_dir = config_home..'/nvim'
  local toml = rc_dir..'/dein.toml'
  local lazy_toml = rc_dir..'/dein_lazy.toml'
  fn['dein#begin'](dein_dir)
  fn['dein#load_toml'](toml, { lazy = 0 })
  fn['dein#end']()
  fn['dein#save_state']()
end

-- plugin installation check
if (fn['dein#check_install']() ~= 0) then
  fn['dein#install']()
end

-- plugin remove check
local removed_plugins = fn['dein#check_clean']()
if fn.len(removed_plugins) > 0 then
  fn.map(removed_plugins, "delete(v:val, 'rf')")
  fn['dein#recache_runtimepath']()
end
