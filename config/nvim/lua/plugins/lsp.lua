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

--[[ nvim-lsp-installer settings ]]
local lsp_installer = require("nvim-lsp-installer")

local servers = {
  "sumneko_lua",
  "solargraph",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = custom_on_attach,
    on_init = custom_on_init,
    capabilities = custom_capabilities,
  }

  local enhance_server_opts = {
    ["solargraph"] = function()
      return vim.tbl_deep_extend("force", opts, {
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
    end,
    ["sumneko_lua"] = function()
      return vim.tbl_deep_extend("force", opts, {
        filetypes = { "lua" },
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
    end,
  }

  server:setup(enhance_server_opts[server.name] and enhance_server_opts[server.name]() or opts)
end)
