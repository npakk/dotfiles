--[[
  TODO: Packer doesn't support git submodule.
  check this: https://github.com/wbthomason/packer.nvim/issues/99

  how to fix:
  1. cd plugin_direcotry(.local/share/nvim/site/pack/packer/[opt|start]/[plugin])
  2. git submodule init
  3. git submodule update
  4. don't forget compiling packer settings
]]

local packer = nil
local function init()
  if packer == nil then
    packer = require("packer")
    packer.init({ disable_commands = true })
  end

  local use = packer.use
  packer.reset()

  --[[ Built-in Helper ]]

  use({ "wbthomason/packer.nvim", opt = true })
  use({ "tjdevries/astronauta.nvim" }) -- temporary stuff before it got merged upstream

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
    requires = {
      { "glepnir/lspsaga.nvim", opt = true },
    },
  })

  -- Debug Adapter Protocol client implementation for Neovim
  use({
    "mfussenegger/nvim-dap",
    ft = { "python" },
    requires = {
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    config = require("plugins.dap").config,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter *" },
    config = require("plugins.completion").config,
    requires = {
      { "onsails/lspkind-nvim", opt = true },
    },
  })
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-vsnip", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
  use({ "octaltree/cmp-look", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
  use({ "tzachar/cmp-tabnine", after = "nvim-cmp", run = "./install.sh" })
  use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
  use({ "f3fora/cmp-spell", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })

  -- Snippets
  use({
    "hrsh7th/vim-vsnip",
    event = { "InsertCharPre *" },
    setup = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = require("plugins.treesitter").config,
    requires = {
      { "nvim-treesitter/nvim-treesitter-refactor", opt = true },
      { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
      { "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
      { "p00f/nvim-ts-rainbow", opt = true },
      { "windwp/nvim-ts-autotag", opt = true },
    },
  })

  -- Symbols
  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    setup = function()
      vim.api.nvim_set_keymap("n", "<leader>s", [[:SymbolsOutline<CR>]], { noremap = true, silent = true })
    end,
  })

  -- show highlight vitual text
  use({
    "kevinhwang91/nvim-hlslens",
    setup = function()
      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<cmd>execute("normal! " . v:count1 . "n")<CR><cmd>lua require"hlslens".start()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<cmd>execute("normal! " . v:count1 . "N")<CR><cmd>lua require"hlslens".start()<CR>]],
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap("x", "*", [[*<cmd>lua require"hlslens".start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "#", [[#<cmd>lua require"hlslens".start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("x", "g*", [[g*<cmd>lua require"hlslens".start()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("x", "g#", [[g#<cmd>lua require"hlslens".start()<CR>]], { noremap = true, silent = true })
    end,
  })

  -- show keybindings
  use({
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          spelling = { enabled = true, suggestions = 60 },
          presets = {
            operators = false,
          },
        },
        window = { border = "single" },
      })
    end,
  })

  --[[ Enhancement ]]

  -- fzf
  use({
    "nvim-telescope/telescope.nvim",
    setup = function()
      require("plugins.telescope").setup()
    end,
    config = require("plugins.telescope").config,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
      { "kyazdani42/nvim-web-devicons" },
      { "nvim-telescope/telescope-fzf-writer.nvim", opt = true },
      { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
      {
        "nvim-telescope/telescope-frecency.nvim",
        opt = true,
        requires = { "tami5/sql.nvim", opt = true },
      },
      { "nvim-telescope/telescope-github.nvim", opt = true },
      { "nvim-telescope/telescope-ghq.nvim", opt = true },
    },
  })

  -- Formatter
  use({
    "mhartington/formatter.nvim",
    event = { "BufWritePre *.lua" },
    cmd = { "Format" },
    setup = require("plugins.formatter").setup,
    config = require("plugins.formatter").config,
  })

  -- Explorer
  -- TODO: No file content.
  -- check this: https://github.com/kyazdani42/nvim-tree.lua/issues/495
  use({
    "kyazdani42/nvim-tree.lua",
    setup = function()
      vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache", ".DS_Store", ".localized" }
      vim.g.nvim_tree_gitignore = 1
      vim.g.nvim_tree_auto_ignore_ft = ""
      vim.g.nvim_tree_git_hl = 1
      vim.g.nvim_tree_width_allow_resize = 0
      vim.g.nvim_tree_disable_netrw = 0
      vim.g.nvim_tree_hijack_netrw = 0
      vim.g.nvim_tree_group_empty = 1
      vim.g.nvim_tree_lsp_diagnostics = 1
      vim.g.nvim_tree_update_cwd = 1
      vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0,
      }

      vim.api.nvim_set_keymap("n", "<leader>e", [[:NvimTreeToggle<CR>]], { noremap = true, silent = true })
    end,
    requires = {
      { "kyazdani42/nvim-web-devicons" },
    },
  })

  -- Motion
  use({
    "phaazon/hop.nvim",
    setup = function()
      vim.api.nvim_set_keymap("n", "<leader>w", [[<cmd>HopWord<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>i", [[<cmd>HopLine<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("x", "<leader>i", [[<cmd>HopLine<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("n", "<leader><Space>", [[<cmd>HopPattern<CR>]], { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap("x", "<leader><Space>", [[<cmd>HopPattern<CR>]], { noremap = true, silent = true })
    end,
    config = function()
      require("hop").setup({
        create_hl_autocmd = true,
      })
    end,
  })

  -- Surround
  use({ "tpope/vim-surround" })

  -- Comment
  use({
    "b3nj5m1n/kommentary",
    config = function()
      require("kommentary.config").configure_language("default", {
        single_line_comment_string = "auto",
        multi_line_comment_strings = "auto",
        hook_function = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })
    end,
  })

  -- Brackets
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  })

  -- Emmet
  use({
    "mattn/emmet-vim",
    key = { { "i", "<C-z>" } },
    setup = function()
      vim.g.user_emmet_leader_key = "<C-z>"
    end,
  })

  -- Git
  use({
    "tpope/vim-fugitive",
    setup = function()
      vim.api.nvim_set_keymap("n", "<leader>gs", [[:vert Git<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ga", [[:Gwrite<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gm", [[:GRename<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gr", [[:Gread<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gR", [[:GRemove<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gd", [[:Gdiff<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gb", [[:Gblame<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gl", [[:Glog<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gw", [[:GBrowse<CR>]], { noremap = true, silent = true })
    end,
    requires = {
      { "tpope/vim-rhubarb" },
    },
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = require("plugins.gitsigns").config,
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
  })

  -- Markdown
  use({
    "npxbr/glow.nvim",
    cmd = { "Glow" },
    setup = function()
      vim.api.nvim_set_keymap("n", "<leader>p", [[:Glow<CR>]], { noremap = true, silent = true })
    end,
  })
  use({
    "mattn/vim-maketable",
    cmd = { "MakeTable", "UnmakeTable" },
    setup = function()
      vim.api.nvim_set_keymap("x", "<leader>tt", [[:MakeTable!<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>tu", [[:UnmakeTable<CR>]], { noremap = true, silent = true })
    end,
  })

  --[[ Appearance ]]

  -- colorscheme
  use({
    "npxbr/gruvbox.nvim",
    opt = true,
    requires = { "rktjmp/lush.nvim", opt = true },
  })
  use({ "kyazdani42/blue-moon", opt = true })

  -- statusline
  use({
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
        },
        extensions = { "fugitive", "nvim-tree" },
      })
    end,
    requires = {
      { "kyazdani42/nvim-web-devicons" },
    },
  })

  -- bufferline
  use({
    "akinsho/nvim-bufferline.lua",
    event = "VimEnter",
    setup = require("plugins.bufferline").setup,
    config = require("plugins.bufferline").config,
    requires = {
      { "kyazdani42/nvim-web-devicons" },
    },
  })

  -- Indent
  use({
    "glepnir/indent-guides.nvim",
    config = function()
      require("indent_guides").setup({
        indent_guides_auto_colors = 1,
      })
    end,
  })

  -- coloring RGBcode
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "!markdown",
      })
    end,
  })
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
