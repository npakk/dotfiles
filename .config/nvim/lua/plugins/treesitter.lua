return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      keys = {
        {
          "<leader>s",
          "<cmd>lua require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')<CR>",
          desc = "Swap Next",
        },
        {
          "<leader>S",
          "<cmd>lua require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')<CR>",
          desc = "Swap Previous",
        },
      },
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua",
        "markdown",
        "query",
        "vimdoc",
      })
    end,
  },
}
