return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "debugloop/telescope-undo.nvim",
        keys = {
          { "<leader>u", "<cmd>Telescope undo<CR>", desc = "Telescope undo" },
        },
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>cd", "<cmd>lua require('telescope.builtin').find_files({cwd = '~/dotfiles', hidden = true})<CR>",             desc = "Telescope dotfiles" },
      { "<leader>cn", "<cmd>lua require('telescope.builtin').find_files({cwd = '~/dotfiles/config/nvim', hidden = true})<CR>", desc = "Telescope nvim_dotfiles" },
      { "<leader>f",  "<cmd>Telescope find_files<CR>",                                                                         desc = "Telescope find_files" },
      { "<leader>g",  "<cmd>Telescope live_grep<CR>",                                                                          desc = "Telescope live_grep" },
      { "<leader>h",  "<cmd>Telescope help_tags<CR>",                                                                          desc = "Telescope help_tags" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.5,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
          winblend = 0,
          file_ignore_patterns = {
            "^.git/",
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--follow",
          },
          mappings = {
            n = {
              ["q"] = actions.close,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
            },
          },
        },
      })
    end,
  },
}
