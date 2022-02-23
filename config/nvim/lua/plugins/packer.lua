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

  -- LSP
  use({ "williamboman/nvim-lsp-installer" })
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
    requires = {
      { "tami5/lspsaga.nvim", opt = true },
    },
    after = "nvim-lsp-installer",
  })

  -- Debug Adapter Protocol client
  use({
    "mfussenegger/nvim-dap",
    ft = { "python" },
    setup = require("plugins.dap").setup,
    config = require("plugins.dap").config,
    requires = {
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter *" },
    config = function()
      require("plugins.completion")
    end,
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

  -- Snippet
  use({
    "hrsh7th/vim-vsnip",
    event = { "InsertEnter *" },
    setup = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
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
      require("plugins.hlslens")
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

  -- auto-resizing window
  use({
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  })

  -- join-line using textobject
  use({
    "AckslD/nvim-revJ.lua",
    config = function()
      vim.cmd([[
      packadd vim-textobj-user
      packadd vim-textobj-parameter
      ]])
      require("revj").setup({
        brackets = { first = "([{<", last = ")]}>" },
        new_line_before_last_bracket = true,
        add_seperator_for_last_parameter = true,
        enable_default_keymaps = false,
        keymaps = {
          operator = "<Leader>J",
          line = "<Leader>j",
          visual = "<Leader>j",
        },
        parameter_mapping = ",",
      })
    end,
    requires = {
      { "kana/vim-textobj-user", opt = true },
      { "sgur/vim-textobj-parameter", opt = true },
    },
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

  -- Linter
  use({
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufEnter *.md,*.txt,*.py" },
    config = function()
      require("plugins.linter")
    end,
  })

  -- Formatter
  use({
    "mhartington/formatter.nvim",
    event = { "BufWritePre *.js,*.py,*.lua" },
    cmd = { "Format" },
    setup = require("plugins.formatter").setup,
    config = require("plugins.formatter").config,
  })

  -- Explorer
  use({
    "kyazdani42/nvim-tree.lua",
    setup = require("plugins.nvim-tree").setup,
    config = require("plugins.nvim-tree").config,
    requires = {
      { "kyazdani42/nvim-web-devicons" },
    },
  })

  -- Motion
  use({
    "phaazon/hop.nvim",
    setup = function()
      local api = vim.api
      local kopts = { noremap = true, silent = true }
      api.nvim_set_keymap("n", "<leader>w", [[<cmd>HopWord<CR>]], kopts)
      api.nvim_set_keymap("x", "<leader>w", [[<cmd>HopWord<CR>]], kopts)
      api.nvim_set_keymap("n", "<leader>i", [[<cmd>HopLine<CR>]], kopts)
      api.nvim_set_keymap("x", "<leader>i", [[<cmd>HopLine<CR>]], kopts)
      api.nvim_set_keymap("n", "<leader><Space>", [[<cmd>HopPattern<CR>]], kopts)
      api.nvim_set_keymap("x", "<leader><Space>", [[<cmd>HopPattern<CR>]], kopts)
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
      local kommentary = require("kommentary.config")
      kommentary.configure_language("default", {
        single_line_comment_string = "auto",
        multi_line_comment_strings = "auto",
        hook_function = function()
          require("ts_context_commentstring.internal").update_commentstring()
        end,
      })
      kommentary.configure_language("lua", {
        prefer_single_line_comments = true,
      })
    end,
  })

  -- Brackets
  use({
    "windwp/nvim-autopairs",
    setup = function() end,
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          hightlight = "Search",
        },
      })
    end,
  })

  -- Emmet
  use({
    "mattn/emmet-vim",
    key = { { "i", "<C-y>" } },
    setup = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  })

  -- Git
  use({
    "tpope/vim-fugitive",
    setup = function()
      local api = vim.api
      local kopts = { noremap = true, silent = true }
      -- api.nvim_set_keymap("n", "<leader>gs", [[:vert Git<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>ga", [[:Gwrite<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gm", [[:GRename<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gr", [[:Gread<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gR", [[:GRemove<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gd", [[:Gdiff<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gb", [[:Gblame<CR>]], kopts)
      -- api.nvim_set_keymap("n", "<leader>gl", [[:Glog<CR>]], kopts)
      api.nvim_set_keymap("n", "<leader>gw", [[:GBrowse<CR>]], kopts)
    end,
    requires = {
      { "tpope/vim-rhubarb" },
    },
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
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

  use({
    "aserowy/tmux.nvim",
    setup = function()
      local api = vim.api
      local kopts = { noremap = true, silent = true }
      api.nvim_set_keymap("n", "<M-h>", [[<cmd>lua require("tmux").move_left()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-j>", [[<cmd>lua require("tmux").move_bottom()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-k>", [[<cmd>lua require("tmux").move_top()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-l>", [[<cmd>lua require("tmux").move_right()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-Left>", [[<cmd>lua require("tmux").resize_left()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-Down>", [[<cmd>lua require("tmux").resize_bottom()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-Up>", [[<cmd>lua require("tmux").resize_top()<cr>]], kopts)
      api.nvim_set_keymap("n", "<M-Right>", [[<cmd>lua require("tmux").resize_right()<cr>]], kopts)
    end,
    config = function()
      require("tmux").setup({
        copy_sync = {
          enable = false,
          redirect_to_clipboard = false,
          sync_clipboard = false,
        },
        navigation = {
          enable_default_keybindings = false,
        },
        resize = {
          enable_default_keybindings = false,
          resize_step_x = 3,
          resize_step_y = 3,
        },
      })
    end,
  })

  --[[ Appearance ]]

  -- colorscheme
  use({
    "sainnhe/gruvbox-material",
    opt = true,
  })

  -- statusline
  use({
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox-material",
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
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.cmd([[highlight IndentBlanklineContextChar guifg=#5A5450 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent1 guifg=#3B3735 blend=nocombine]])
      require("indent_blankline").setup({
        char_highlight_list = {
          "IndentBlanklineIndent1",
        },
        show_current_context = true,
      })
    end,
  })

  -- coloring RGBcode
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        "!markdown",
      })
    end,
  })

  -- Scroll bar
  use({
    "Xuyuanp/scrollbar.nvim",
    setup = function()
      vim.cmd(
        [[
        augroup your_config_scrollbar_nvim
        autocmd!
        autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
        autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
        autocmd WinLeave,BufLeave,BufWinLeave,FocusLost * silent! lua require('scrollbar').clear()
        augroup end
        let g:scrollbar_max_size = 10
        let g:scrollbar_min_size = 3
        let g:scrollbar_right_offset = 0
        let g:scrollbar_shape = {
        \ 'head': '▲',
        \ 'body': '|',
        \ 'tail': '▼',
        \ }
        ]],
        true
      )
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
