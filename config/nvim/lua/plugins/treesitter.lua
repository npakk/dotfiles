return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "markdown",
          "query",
          "vimdoc",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          swap = {
            enable = true,
            swap_next = { ["<leader>s"] = "@parameter.inner" },
            swap_previous = { ["<leader>S"] = "@parameter.inner" },
          },
        },
      })
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = { { "<leader>j", "<cmd>TSJToggle<CR>" } },
    opts = { use_default_keymaps = false },
  },
}
