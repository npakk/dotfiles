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
    opts = { modes = { treesitter_search = { label = { rainbow = { enabled = true } } } } },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon"):list():append() end,                                 desc = "Add Mark" },
      { "<C-e>",     function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Quick Menu" },
    },
    opts = {},
  },
}
