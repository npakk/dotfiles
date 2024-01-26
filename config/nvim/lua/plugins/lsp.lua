--[[ Mason settings ]]
vim.cmd([[packadd mason.nvim]])
local mason = require("mason").setup()
vim.cmd([[packadd mason-lspconfig.nvim]])
local mason_lspconfig = require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")

-- mason_lspconfig.setup_handlers({
--   function(server_name)
--     lspconfig[server_name].setup({})
--   end,
-- })

--[[ Lspsaga settings ]]
vim.cmd([[packadd lspsaga.nvim]])
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga({
  use_saga_diagnostic_sign = true,
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  code_action_icon = "",
  code_action_prompt = {
    enable = true,
    sign = false,
    virtual_text = true,
  },
})

local custom_on_attach = function(client, bufnr)
  local api = vim.api
  local kopts = { noremap = true, silent = true }

  --[[ Lspsaga key-settings ]]
  api.nvim_set_keymap("n", "gh", [[:Lspsaga lsp_finder<CR>]], kopts)
  api.nvim_set_keymap("n", "ga", [[:Lspsaga code_action<CR>]], kopts)
  api.nvim_set_keymap("v", "ga", [[:Lspsaga range_code_action<CR>]], kopts)
  api.nvim_set_keymap("n", "K", [[:Lspsaga hover_doc<CR>]], kopts)
  api.nvim_set_keymap("n", "<C-f>", [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>]], kopts)
  api.nvim_set_keymap("n", "<C-b>", [[<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>]], kopts)
  api.nvim_set_keymap("n", "gs", [[:Lspsaga signature_help<CR>]], kopts)
  api.nvim_set_keymap("n", "gr", [[:Lspsaga rename<CR>]], kopts)
  api.nvim_set_keymap("n", "gD", [[:Lspsaga preview_definition<CR>]], kopts)
  api.nvim_set_keymap("n", "gp", [[:Lspsaga show_line_diagnostics<CR>]], kopts)
  api.nvim_set_keymap("n", "]e", [[:Lspsaga diagnostic_jump_next<CR>]], kopts)
  api.nvim_set_keymap("n", "[e", [[:Lspsaga diagnostic_jump_prev<CR>]], kopts)

  api.nvim_set_keymap("n", "gt", [[<cmd>lua vim.lsp.buf.type_definition()<CR>]], kopts)
  api.nvim_set_keymap("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]], kopts)
  api.nvim_set_keymap("n", "gl", [[<cmd>lua vim.lsp.buf.declaration()<CR>]], kopts)
  api.nvim_set_keymap("n", "gP", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>Wa", [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>Wr", [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]], kopts)
  api.nvim_set_keymap(
    "n",
    "<leader>Wl",
    [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]],
    kopts
  )

  local ft_auto_format = {
    "ruby",
  }

  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  if vim.tbl_contains(ft_auto_format, filetype) then
    -- ↓ available format only filetype
    -- vim.api.nvim_set_keymap("n", "gF", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], kopts)

    -- ↓ format on save
    vim.cmd([[autocmd MyFormatAutoCmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
  end
end

local custom_on_init = function()
  print("Language Server Protocol started!")
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true
