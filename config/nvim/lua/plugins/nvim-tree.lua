local M = {}

function M.setup()
  vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache", ".DS_Store", ".localized" }
  vim.g.nvim_tree_gitignore = 1
  vim.g.nvim_tree_auto_ignore_ft = ""
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_width_allow_resize = 0
  vim.g.nvim_tree_disable_netrw = 0
  vim.g.nvim_tree_hijack_netrw = 0
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_lsp_diagnostics = 1
  vim.g.nvim_tree_update_cwd = 1
  vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
  }

  vim.api.nvim_set_keymap("n", "<leader>e", [[:NvimTreeToggle<CR>]], { noremap = true, silent = true })
end

return M
