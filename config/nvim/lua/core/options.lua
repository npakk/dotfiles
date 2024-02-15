--[[ global ]]

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.encoding = "utf-8"
vim.opt.backup = false
vim.opt.title = true
vim.opt.laststatus = 0
vim.opt.hidden = true
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmode = { "full", "lastused", "list" }
vim.opt.scrolloff = 5
if vim.fn.has("unix") == 1 then
  vim.opt.clipboard = "unnamedplus"
else
  vim.opt.clipboard = "unnamed"
end

--[[ window-local ]]

vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "| ",
  trail = "･",
  extends = "»",
  precedes = "«",
  nbsp = "%",
}
vim.opt.signcolumn = "auto"
vim.opt.spelllang:append("cjk")
vim.opt.spell = true

--[[ buffer-local ]]

vim.opt.nrformats = "unsigned"
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*",
  group = "MyAutoCmd",
  command = "set formatoptions-=cro",
})
vim.opt.tabstop = 2
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.matchpairs:append({
  "<:>",
  "「:」",
  "『:』",
  "（:）",
  "【:】",
  "《:》",
  "〈:〉",
  "［:］",
  "':'",
  "“:”",
})
vim.opt.shada = { "!", "'1000", "<50", "s10", "h", "n~/.cache/nvim/.viminfo" }
vim.opt.undofile = true
