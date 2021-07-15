local M = {}

function M.setup()
  local k = require("astronauta.keymap")
  local nnoremap = k.nnoremap

  nnoremap({ "gF", [[<cmd>Format<CR>]], { silent = true } })
end

function M.config()
  local stylua_root = vim.fn.stdpath("config") .. "/lua/modules/StyLua/"
  local stylua = function()
    return {
      exe = stylua_root .. "stylua --config-path ~/.config/nvim/.stylua -",
      stdin = true,
    }
  end

  require("formatter").setup({
    logging = false,
    filetype = {
      --[[ typescriptreact = { prettier },
      javascript = { prettier },
      typescript = { prettier },
      svelte     = { prettier },
      css        = { prettier },
      jsonc      = { prettier },
      json       = { prettier },
      html       = { prettier },
      php        = { prettier },
      rust       = { rustfmt },
      go         = { gofmt }, ]]
      lua = { stylua },
    },
  })

  vim.api.nvim_exec(
    [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePre *.js,*.rs,*.lua FormatWrite
    augroup END
    ]],
    true
  )
end

return M
