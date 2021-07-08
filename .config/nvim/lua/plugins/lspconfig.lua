vim.cmd [[packadd lspsaga.nvim]]

--[[ Built-in LSP Appearance ]]
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      prefix = '»',
      spacing = 4,
    },
    signs = { priority = 20 },
    update_in_insert = false,
  }
)

vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" })

local lspconfig = require('lspconfig')
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga()

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.solargraph.setup{
  cmd = { 'solargraph', 'stdio' },
  capabilities = custom_capabilities,
  filetypes = { 'ruby' },
  settings = {
    solargraph = {
      completion = true,
      definitions = true,
      diagnostics = true,
      folding = true,
      formatting = true,
      hover = true,
      references = true,
      symbols = true
    }
  }
}
