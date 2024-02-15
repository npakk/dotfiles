return {
  {
    "oahlen/iceberg.nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme iceberg]])
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    event = "VimEnter",
    opts = {
      options = { theme = "iceberg_dark" },
      extensions = { "lazy", "mason" },
    },
  },
  {
    "aserowy/tmux.nvim",
    keys = {
      { "<C-h>", "<cmd>lua require('tmux').move_left()<CR>" },
      { "<C-j>", "<cmd>lua require('tmux').move_bottom()<CR>" },
      { "<C-k>", "<cmd>lua require('tmux').move_top()<CR>" },
      { "<C-l>", "<cmd>lua require('tmux').move_right()<CR>" },
      { "<S-Left>", "<cmd>lua require('tmux').resize_left()<CR>" },
      { "<S-Down>", "<cmd>lua require('tmux').resize_bottom()<CR>" },
      { "<S-Up>", "<cmd>lua require('tmux').resize_top()<CR>" },
      { "<S-Right>", "<cmd>lua require('tmux').resize_right()<CR>" },
    },
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
        resize_step_x = 3,
        resize_step_y = 3,
      },
    },
  },
  -- {
  --   "kevinhwang91/nvim-hlslens",
  --   keys = {
  --     { "n", "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>" },
  --     { "N", "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>" },
  --     { "*", "*<cmd>lua require'hlslens'.start()<CR>" },
  --     { "#", "#<cmd>lua require'hlslens'.start()<CR>" },
  --     { "g*", "g*<cmd>lua require'hlslens'.start()<CR>" },
  --     { "g#", "g#<cmd>lua require'hlslens'.start()<CR>" },
  --   },
  --   calm_down = { default = true },
  -- },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "BufReadPre",
  --   opts = {
  --     on_attach = function(bufnr)
  --       local gs = package.loaded.gitsigns
  --
  --       local function map(mode, l, r, opts)
  --         opts = opts or {}
  --         opts.buffer = bufnr
  --         vim.keymap.set(mode, l, r, opts)
  --       end
  --
  --       -- Navigation
  --       map("n", "]c", function()
  --         if vim.wo.diff then
  --           return "]c"
  --         end
  --         vim.schedule(function()
  --           gs.next_hunk()
  --         end)
  --         return "<Ignore>"
  --       end, { expr = true })
  --
  --       map("n", "[c", function()
  --         if vim.wo.diff then
  --           return "[c"
  --         end
  --         vim.schedule(function()
  --           gs.prev_hunk()
  --         end)
  --         return "<Ignore>"
  --       end, { expr = true })
  --
  --       -- Actions
  --       map("n", "<leader>hr", gs.reset_hunk)
  --       map("v", "<leader>hr", function()
  --         gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  --       end)
  --       map("n", "<leader>hR", gs.reset_buffer)
  --       map("n", "<leader>hp", gs.preview_hunk)
  --       map("n", "<leader>hb", function()
  --         gs.blame_line({ full = true })
  --       end)
  --       map("n", "<leader>hd", gs.diffthis)
  --     end,
  --   },
  -- },
  -- {
  --   "petertriho/nvim-scrollbar",
  --   dependencies = {
  --     { "kevinhwang91/nvim-hlslens" },
  --     { "lewis6991/gitsigns.nvim" },
  --   },
  --   event = "BufReadPre",
  --   config = function()
  --     require("scrollbar.handlers.search").setup()
  --     require("scrollbar.handlers.gitsigns").setup()
  --     require("scrollbar").setup({
  --       marks = { GitAdd = { text = "│" }, GitChange = { text = "│" } },
  --       handlers = { search = true, gitsigns = true },
  --     })
  --   end,
  -- },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require("ibl").setup()
  --   end,
  -- },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      { "aserowy/tmux.nvim" },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    opts = { plugins = { tmux = true } },
  },
  -- {
  --   "folke/noice.nvim",
  --   dependencies = {
  --     { "MunifTanjim/nui.nvim" },
  --   },
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  -- TODO:
  -- copilot
  -- refactoring
  -- trouble
  -- harpoon
  -- fugitive
}
