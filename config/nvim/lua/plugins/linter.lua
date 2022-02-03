local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.diagnostics.textlint,
}

null_ls.register({ filetypes = { "markdown" }, sources = sources })
null_ls.setup()
