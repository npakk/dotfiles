local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "<leader>e", [[:NvimTreeToggle<CR>]], { noremap = true, silent = true })
end

function M.config()
  require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    diagnostics = {
      enable = true,
      icons = {
        error = "",
        warning = "",
        info = "",
        hint = "",
      },
    },
    update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    filters = {
      dotfiles = false,
      custom = { ".git", "node_modules", ".cache", ".DS_Store", ".localized" },
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
        },
      },
    },
    view = {
      adaptive_size = true,
      width = 30,
      side = "left",
      number = true,
      relativenumber = true,
      signcolumn = "auto",
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  })
end

return M
