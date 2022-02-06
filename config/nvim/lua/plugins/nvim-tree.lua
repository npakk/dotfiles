local M = {}

function M.setup()
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
  }

  vim.api.nvim_set_keymap("n", "<leader>e", [[:NvimTreeToggle<CR>]], { noremap = true, silent = true })
end

function M.config()
  require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = false,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    open_on_tab = false,
    update_to_buf_dir = {
      enable = false,
      auto_open = true,
    },
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
    view = {
      width = 30,
      height = 30,
      side = "left",
      auto_resize = true,
      mappings = {
        custom_only = false,
        list = {},
      },
      number = true,
      relativenumber = true,
      signcolumn = "yes",
    },
  })
end

return M
