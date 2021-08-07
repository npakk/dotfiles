local M = {}

function M.config()
  require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "always",
    source = {
      path = true,
      buffer = true,
      tags = true,
      spell = true,
      calc = true,
      emoji = true,
      nvim_lsp = {
        priority = 100,
      },
      nvim_lua = true,
      vsnip = {
        priority = 1000,
      },
      snippets_nvim = false,
      treesitter = true,
    },
  })

  --[[ Key Mappings ]]

  -- autopairs integration nvim-compe
  -- https://github.com/windwp/nvim-autopairs#mapping-cr
  require("nvim-autopairs.completion.compe").setup({
    map_cr = true,
    map_complete = true,
  })

  -- use tab navigation
  -- https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
  end
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t("<Down>")
    elseif vim.fn["vsnip#available"](1) == 1 then
      return t("<Plug>(vsnip-expand-or-jump)")
    elseif check_back_space() then
      return t("<Tab>")
    else
      return vim.fn["compe#complete"]()
    end
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t("<Up>")
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      return t("<Plug>(vsnip-jump-prev)")
    else
      return t("<S-Tab>")
    end
  end
  local kopts = { expr = true, noremap = true, silent = true }
  vim.api.nvim_set_keymap("i", "<Tab>", [[v:lua.tab_complete()]], { expr = true })
  vim.api.nvim_set_keymap("s", "<Tab>", [[v:lua.tab_complete()]], { expr = true })
  vim.api.nvim_set_keymap("i", "<S-Tab>", [[v:lua.s_tab_complete()]], { expr = true })
  vim.api.nvim_set_keymap("s", "<S-Tab>", [[v:lua.s_tab_complete()]], { expr = true })

  vim.api.nvim_set_keymap("i", "<C-Space>", [[compe#complete()]], kopts)
  vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm(luaeval("require('nvim-autopairs').autopairs_cr()"))]], kopts)
  vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close("<C-e>")]], kopts)
  vim.api.nvim_set_keymap("i", "<C-f>", [[compe#scroll({ 'delta': +4 })]], kopts)
  vim.api.nvim_set_keymap("i", "<C-d>", [[compe#scroll({ 'delta': -4 })]], kopts)
end

return M
