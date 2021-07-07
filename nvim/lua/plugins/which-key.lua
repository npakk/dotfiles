local M = {}

function M.config()
  local wk = require('which-key')
  wk.setup {
    plugins = {
      marks = true,
      registers = true,


    },
  }
end

return M
