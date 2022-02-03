local api = vim.api
local kopts = { noremap = true, silent = true }
api.nvim_set_keymap(
  "n",
  "n",
  [[<cmd>execute("normal! " . v:count1 . "n")<CR><cmd>lua require"hlslens".start()<CR>]],
  kopts
)
api.nvim_set_keymap(
  "n",
  "N",
  [[<cmd>execute("normal! " . v:count1 . "N")<CR><cmd>lua require"hlslens".start()<CR>]],
  kopts
)
api.nvim_set_keymap("x", "*", [[*<cmd>lua require"hlslens".start()<CR>]], kopts)
api.nvim_set_keymap("n", "#", [[#<cmd>lua require"hlslens".start()<CR>]], kopts)
api.nvim_set_keymap("x", "g*", [[g*<cmd>lua require"hlslens".start()<CR>]], kopts)
api.nvim_set_keymap("x", "g#", [[g#<cmd>lua require"hlslens".start()<CR>]], kopts)
