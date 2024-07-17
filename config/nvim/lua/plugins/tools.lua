return {
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "folke/flash.nvim",
    lazy = false,
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = { "o" },           function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    opts = {
      label = { rainbow = { enabled = true } },
      highlight = { matches = false },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end,                                    desc = "Add Mark" },
      { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Quick Menu" },
    },
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      {
        "<leader>m",
        "<cmd>ObsidianQuickSwitch<CR>",
        desc = "Telescope obsidian",
      },
    },
    opts = {
      workspaces = {
        {
          name = "default",
          path = "~/Documents/default",
        },
      },
    },
  },
}
