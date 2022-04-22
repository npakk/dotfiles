vim.cmd([[packadd nvim-treesitter-refactor]])
vim.cmd([[packadd nvim-treesitter-textobjects]])
vim.cmd([[packadd nvim-ts-context-commentstring]])
vim.cmd([[packadd nvim-ts-rainbow]])
vim.cmd([[packadd nvim-ts-autotag]])

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  ignore_install = {},

  highlight = {
    enable = true,
    custom_captures = {},
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true,
    disable = {
      "ruby",
    },
  },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "gR",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gT",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["iS"] = "@statement.inner",
        ["aS"] = "@statement.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
        ["ad"] = "@comment.outer",
        ["id"] = "@comment.inner",
      },
    },

    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },

    swap = {
      enable = true,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },

    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dc"] = "@class.outer",
      },
    },
  },

  context_commentstring = { enable = true, enable_autocmd = false },

  rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },

  autotag = { enable = true },

  autopairs = { enable = true },
})
