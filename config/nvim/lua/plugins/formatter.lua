local M = {}

function M.setup()
  -- vim.api.nvim_set_keymap("n", "gF", [[<cmd>Format<CR>]], { noremap = true, silent = true })
end

function M.config()
  -- TODO: silent monkey patch
  -- check this: https://github.com/mhartington/formatter.nvim/issues/48
  require("formatter.util").print = function() end

  local prettier = function()
    return {
      exe = "yarn -s run prettier",
      args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
      stdin = true,
    }
  end

  local isort = function()
    return {
      exe = "isort",
      args = { "-q", "-" },
      stdin = true,
    }
  end

  local black = function()
    return {
      exe = "black",
      args = { "-q", "-" },
      stdin = true,
    }
  end

  local stylua_root = "~/.cargo/bin/"
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
      typescript = { prettier },
      svelte     = { prettier },
      css        = { prettier },
      jsonc      = { prettier },
      json       = { prettier },
      html       = { prettier },
      php        = { prettier },
      rust       = { rustfmt },
      go         = { gofmt }, ]]
      javascript = { prettier },
      python = { isort, black },
      lua = { stylua },
    },
  })

  vim.cmd([[
    augroup MyFormatAutoCmd
    autocmd!
    autocmd BufWritePost *.js,*.py,*.lua FormatWrite
    augroup END
  ]])
end

return M
