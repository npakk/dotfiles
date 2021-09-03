local M = {}

function M.setup()
  local api = vim.api
  local kopts = { noremap = true, silent = true }
  api.nvim_set_keymap("n", "<leader>1", [[<cmd>BufferLineGoToBuffer 1<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>2", [[<cmd>BufferLineGoToBuffer 2<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>3", [[<cmd>BufferLineGoToBuffer 3<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>4", [[<cmd>BufferLineGoToBuffer 4<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>5", [[<cmd>BufferLineGoToBuffer 5<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>6", [[<cmd>BufferLineGoToBuffer 6<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>7", [[<cmd>BufferLineGoToBuffer 7<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>8", [[<cmd>BufferLineGoToBuffer 8<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader>9", [[<cmd>BufferLineGoToBuffer 9<CR>]], kopts)
  api.nvim_set_keymap("n", "<Right>", [[:BufferLineCycleNext<CR>]], kopts)
  api.nvim_set_keymap("n", "<Left>", [[:BufferLineCyclePrev<CR>]], kopts)
  api.nvim_set_keymap("n", "<Down>", [[:BufferLineMovePrev<CR>]], kopts)
  api.nvim_set_keymap("n", "<Up>", [[:BufferLineMoveNext<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader><Right>", [[:BufferLineCloseRight<CR>]], kopts)
  api.nvim_set_keymap("n", "<leader><Left>", [[:BufferLineCloseLeft<CR>]], kopts)
end

-- numbers = "ordinal",
-- number_style = "",
-- mappings = true,
function M.config()
  require("bufferline").setup({
    options = {
      numbers = function(opts)
        return string.format("%s", opts.raise(opts.id))
      end,
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
