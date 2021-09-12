local M = {}

function M.setup()
  -- vim.api.nvim_set_keymap("n", "gF", [[<cmd>Format<CR>]], { noremap = true, silent = true })
end

function M.config()
  -- TODO: silent monkey patch
  -- check this: https://github.com/mhartington/formatter.nvim/issues/48
  require("formatter.util").print = function() end

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
    autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
    augroup END
    ]],
    true
  )
end

return M
