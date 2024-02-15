return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = {
          { "<leader>f", "<cmd>Telescope file_browser<CR>" },
        },
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<leader>U", "<cmd>Telescope undo<CR>" },
        },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
    keys = {
      { "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", mode = { "c" }, { nowait = true } },
      {
        "<leader>cd",
        function()
          require("telescope.builtin").find_files({
            find_command = require("plugins.modules.telescope")._find_command,
            prompt_title = "~ dotfiles ~",
            path_display = { "absolute" },
            cwd = "~/dotfiles",

            file_ignore_patterns = {},
            layout_strategy = "horizontal",
            layout_config = { preview_width = 0.55 },
          })
        end,
        { noremap = true, silent = true },
      },
      {
        "<leader>g",
        function()
          require("telescope.builtin").live_grep({
            path_display = { "shorten" },
            file_ignore_patterns = {},
          })
        end,
        { noremap = true, silent = true },
      },
      {
        "<leader>H",
        function()
          require("telescope.builtin").help_tags({ show_version = true })
        end,
        { noremap = true, silent = true },
      },
    },
    init = function()
      require("plugins.modules.telescope").setup()
    end,
    config = function()
      require("plugins.modules.telescope").config()
    end,
  },
}
