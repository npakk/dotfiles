vim.cmd([[packadd lspsaga.nvim]])

--[[ Built-in LSP Appearance ]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      prefix = "»",
      spacing = 4,
    },
    signs = { priority = 20 },
    update_in_insert = false,
  }
)

vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { text = "", texthl = "LspDiagnosticsDefaultError" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  { text = "", texthl = "LspDiagnosticsDefaultWarning" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  { text = "", texthl = "LspDiagnosticsDefaultInformation" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  { text = "", texthl = "LspDiagnosticsDefaultHint" }
)

local lspconfig = require("lspconfig")
local lspsaga = require("lspsaga")
lspsaga.init_lsp_saga()

local custom_on_attach = function()
  local k = require("astronauta.keymap")
  local nnoremap = k.nnoremap
  local vnoremap = k.vnoremap
  local tnoremap = k.tnoremap

  local provider = require("lspsaga.provider")
  local codeaction = require("lspsaga.codeaction")
  local hover = require("lspsaga.hover")
  local action = require("lspsaga.action")
  local sig_help = require("lspsaga.signaturehelp")
  local rename = require("lspsaga.rename")
  local diagnostic = require("lspsaga.diagnostic")
  local floaterm = require("lspsaga.floaterm")

  nnoremap({ "gh", provider.lsp_finder, { silent = true } })
  nnoremap({ "<leader>ca", codeaction.code_action, { silent = true } })
  vnoremap({ "<leader>ca", codeaction.range_code_action, { silent = true } })
  nnoremap({ "K", hover.render_hover_doc, { silent = true } })
  nnoremap({
    "<C-f>",
    function()
      action.smart_scroll_with_saga(1)
    end,
    { silent = true },
  })
  nnoremap({
    "<C-b>",
    function()
      action.smart_scroll_with_saga(-1)
    end,
    { silent = true },
  })
  nnoremap({ "gF", [[<cmd>lua vim.lsp.buf.formatting()<CR>]], { silent = true } })
  nnoremap({ "gs", sig_help.signature_help, { silent = true } })
  nnoremap({ "gr", rename.rename, { silent = true } })
  nnoremap({ "gd", provider.preview_definition, { silent = true } })
  nnoremap({ "cd", diagnostic.show_line_diagnostics, { silent = true } })
  nnoremap({ "[e", diagnostic.lsp_jump_diagnostic_prev, { silent = true } })
  nnoremap({ "]e", diagnostic.lsp_jump_diagnostic_next, { silent = true } })
  nnoremap({ "<A-d>", floaterm.open_float_terminal, { silent = true } })
  tnoremap({ "<A-d>", floaterm.close_float_terminal, { silent = true } })
end

local custom_on_init = function()
  print('Language Server Protocol started!')
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true

local stylua = {
  formatCommand = vim.fn.stdpath("config") .. "/lua/modules/StyLua/stylua --config-path " .. vim.fn.stdpath("config") .. "/.stylua -",
  formatStdin = true,
}

local textlint = {
  lintCommand = "textlint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m [%trror/%r]" },
}

lspconfig.efm.setup({
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  init_options = {
    rename = false,
    hover = true,
    documentFormatting = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  filetypes = {
    "lua",
    "markdown"
  },
  settings = {
    -- efm work on anyway: https://github.com/mattn/efm-langserver/issues/125
    rootMarkers = { vim.loop.cwd() },
    languages = {
      lua = { stylua },
      markdown = { textlint },
    },
  },
})

local sumneko_root = vim.fn.stdpath("config") .. "/lua/modules/lua-language-server"
lspconfig.sumneko_lua.setup({
  cmd = {
    sumneko_root .. "/bin/macOS/lua-language-server",
    "-E",
    sumneko_root .. "/main.lua",
  },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      workspace = {
        preloadFileSize = 400,
      },
    },
  },
})

lspconfig.solargraph.setup({
  cmd = { "solargraph", "stdio" },
  on_attach = custom_on_attach,
  on_init = custom_on_init,
  capabilities = custom_capabilities,
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      completion = true,
      definitions = true,
      diagnostics = true,
      folding = true,
      formatting = true,
      hover = true,
      references = true,
      symbols = true,
    },
  },
})
