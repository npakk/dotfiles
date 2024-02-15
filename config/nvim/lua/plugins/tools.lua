return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "]]", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" } },
      { "[[", "<Plug>(leap-backward)", mode = { "n", "x", "o" } },
      { "g]", "<Plug>(leap-from-window)", mode = { "n", "x", "o" } },
    },
  },
  -- {
  --   "npxbr/glow.nvim",
  --   keys = { { "<leader>m", "<cmd>Glow<CR>", ft = { "markdown" } } },
  --   opts = {},
  -- },
}
