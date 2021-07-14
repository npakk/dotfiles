local M = {}

function M.config()
  local wk = require("which-key")
  wk.setup({
    plugins = {
      spelling = { enabled = true, suggestions = 60 },
      presets = {
        operators = false,
      },
    },
    window = { border = "single" },
  })
end

return M
