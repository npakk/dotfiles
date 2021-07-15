local M = {}

function M.setup()
  vim.api.nvim_set_keymap(
    "n",
    "<Right>",
    ":BufferLineCycleNext<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<Left>",
    ":BufferLineCyclePrev<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<Down>",
    ":BufferLineMovePrev<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "<Up>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader><Right>",
    ":BufferLineCloseRight<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader><Left>",
    ":BufferLineCloseLeft<CR>",
    { noremap = true, silent = true }
  )
end

function M.config()
  require("bufferline").setup({
    options = {
      numbers = "ordinal",
      number_style = "",
      mappings = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
      offsets = { { filetype = "NvimTree", text = "", text_align = "left" } },
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
    },
  })
end

return M
