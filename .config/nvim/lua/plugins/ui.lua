return {
  {
    "oahlen/iceberg.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme iceberg]])
      vim.cmd([[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
      ]])
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    event = "vimenter",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          globalstatus = true,
          theme = "iceberg_dark",
        },
        sections = {
          lualine_c = {
            {
              "filename",
              path = 2,
            },
          },
        },
      })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    end,
  },
  {
    "aserowy/tmux.nvim",
    keys = {
      { "<C-h>", "<cmd>lua require('tmux').move_left()<CR>", desc = "Move Left" },
      { "<C-j>", "<cmd>lua require('tmux').move_bottom()<CR>", desc = "Move Bottom" },
      { "<C-k>", "<cmd>lua require('tmux').move_top()<CR>", desc = "Move Top" },
      { "<C-l>", "<cmd>lua require('tmux').move_right()<CR>", desc = "Move Right" },
      { "<S-Left>", "<cmd>lua require('tmux').resize_left()<CR>", desc = "Resize Left" },
      { "<S-Down>", "<cmd>lua require('tmux').resize_bottom()<CR>", desc = "Resize Bottom" },
      { "<S-Up>", "<cmd>lua require('tmux').resize_top()<CR>", desc = "Resize Top" },
      { "<S-Right>", "<cmd>lua require('tmux').resize_right()<CR>", desc = "Resize Right" },
    },
    opts = {
      navigation = { enable_default_keybindings = false },
      resize = { enable_default_keybindings = false, resize_step_x = 3, resize_step_y = 3 },
    },
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   keys = { { "<leader>e", "<cmd>NvimTreeToggle<CR>" } },
  --   opts = {},
  -- },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    keys = {
      { "]c", "<cmd>lua require('gitsigns').next_hunk()<CR>", desc = "Next Hunk" },
      { "[c", "<cmd>lua require('gitsigns').prev_hunk()<CR>", desc = "Previous Hunk" },
      { "<leader>hr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", desc = "Reset Hunk" },
      { "<leader>hR", "<cmd>lua require('gitsigns').reset_buffer()<CR>", desc = "Reset Buffer" },
      { "<leader>hp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", desc = "Preview Hunk" },
      { "<leader>hb", "<cmd>lua require('gitsigns').blame_line({ full = true })<CR>", desc = "Blame Line" },
      { "<leader>hd", "<cmd>lua require('gitsigns').diffthis()<CR>", desc = "Diff This" },
    },
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
    },
    opts = { plugins = { gitsigns = true, tmux = true } },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>t", "<cmd>Trouble diagnostics toggle focus=true<CR>", desc = "Trouble diagnostics" },
      { "<leader>o", "<cmd>Trouble symbols toggle focus=true<CR>", desc = "Trouble symbols" },
      { "<leader>r", "<cmd>Trouble lsp toggle focus=true<CR>", desc = "Trouble lsp" },
    },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      { "folke/trouble.nvim" },
    },
    keys = {
      { "<leader>T", "<cmd>TodoTrouble focus=true<CR>", desc = "Todo" },
    },
    opts = {},
  },
}
