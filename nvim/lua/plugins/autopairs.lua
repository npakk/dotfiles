local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')
local npairs = require('nvim-autopairs')
require('nvim-autopairs').setup({
  check_ts = true
})

--[[ npairs.add_rules({
    Rule("def","end","ruby")
      :with_pair(ts_conds.is_not_ts_node({'string'}))
}) ]]
