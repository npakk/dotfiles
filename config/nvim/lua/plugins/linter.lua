local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.diagnostics.textlint.with({
    filetypes = { "markdown", "text" },
  }),
  null_ls.builtins.diagnostics.flake8.with({
    filetypes = { "python" },
  }),
}

null_ls.setup({ sources = sources })
