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
    packer = require('packer')
    packer.init({disable_commands = true})
  end

  local use = packer.use
  packer.reset()

  --[[
  ------------------------------------------------------------------------
  |                              Built-in Helper                         |
  ------------------------------------------------------------------------
  --]]

  -- Packer
  use { 'wbthomason/packer.nvim', opt = true, }

  -- Neovim Lua power-up
  use { 'tjdevries/astronauta.nvim', }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end,
    requires = {
      { 'glepnir/lspsaga.nvim', opt = true, },
    },
  }

  -- Completion
  use {
    'hrsh7th/nvim-compe',
    event = { 'InsertEnter *' },
    config = require('plugins.completion').config,
    requires = {
      {
        'hrsh7th/vim-vsnip',
        event = { 'InsertCharPre *' },
        setup = function()
          vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
        end,
      },
    },
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead *',
    run = ':TSUpdate',
    config = function()
      for _, name in pairs {
        'nvim-treesitter-refactor',
        'nvim-treesitter-textobjects',
        'nvim-ts-context-commentstring',
        'nvim-ts-rainbow',
        'nvim-ts-autotag',
      } do vim.cmd('packadd ' .. name) end
      require('plugins.treesitter').config()
    end,
    requires = {
      { 'nvim-treesitter/nvim-treesitter-refactor', opt = true, },
      { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true, },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true, },
      { 'p00f/nvim-ts-rainbow', opt = true, },
      { 'windwp/nvim-ts-autotag', opt = true, },
    },
  }

  -- Symbols
  use {
    'simrat39/symbols-outline.nvim',
    cmd = { 'SymbolsOutline' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>a', ':SymbolsOutline<CR>', { noremap = true, silent =true })
    end,
  }

  -- show register
  --use { 'tversteeg/registers.nvim', }

  -- show highlight vitual text
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      vim.api.nvim_set_keymap('n', 'n', "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', 'N', "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', '*', "*<cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '#', "#<cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', 'g*', "g*<cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', 'g#', "g#<cmd>lua require'hlslens'.start()<CR>", { noremap = true, silent = true })
    end,
  }

  -- show keybindings
  use {
    'folke/which-key.nvim',
    config = require('plugins.which-key').config,
  }

  --[[
  ------------------------------------------------------------------------
  |                              Enhancement                             |
  ------------------------------------------------------------------------
  --]]

  -- FZF
  use {
    'nvim-telescope/telescope.nvim',
    setup = function() require('plugins.telescope').setup() end,
    config = function()
      for _, name in pairs {
        'telescope-fzf-writer.nvim',
        'telescope-fzy-native.nvim',
        'telescope-frecency.nvim',
        'sql.nvim',
        'telescope-github.nvim',
        'telescope-ghq.nvim',
      } do vim.cmd('packadd ' .. name) end
      require('plugins.telescope').config()
    end,
    requires = {
      { 'nvim-lua/plenary.nvim', },
      { 'nvim-lua/popup.nvim', },
      { 'kyazdani42/nvim-web-devicons', },
      { 'nvim-telescope/telescope-fzf-writer.nvim', opt = true, },
      { 'nvim-telescope/telescope-fzy-native.nvim', opt = true, },
      {
        'nvim-telescope/telescope-frecency.nvim', opt = true,
        requires = { 'tami5/sql.nvim', opt = true, },
      },
      { 'nvim-telescope/telescope-github.nvim', opt = true, },
      { 'nvim-telescope/telescope-ghq.nvim', opt = true, },
    },
  }

  -- Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    setup = function()
      vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '.DS_Store', '.localized' }
      vim.g.nvim_tree_gitignore = 1
      vim.g.nvim_tree_auto_ignore_ft = ''
      vim.g.nvim_tree_git_hl = 1
      vim.g.nvim_tree_width_allow_resize = 0
      vim.g.nvim_tree_disable_netrw = 0
      vim.g.nvim_tree_hijack_netrw = 0
      vim.g.nvim_tree_group_empty = 1
      vim.g.nvim_tree_lsp_diagnostics = 1
      vim.g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 0,
      }

      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', },
    },
  }

  -- Motion
  use {
    'phaazon/hop.nvim',
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>w', '<cmd>HopWord<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>l', '<cmd>HopLine<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('x', '<leader>l', '<cmd>HopLine<CR>', { noremap = true, silent = true })
    end,
    config = function()
      require('hop').setup {
        create_hl_autocmd = true,
      }
    end,
  }

  -- Surround
  use { 'tpope/vim-surround', }

  -- Comment
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require('kommentary.config').configure_language("default", {
        single_line_comment_string = 'auto',
        multi_line_comment_strings = 'auto',
        hook_function = function()
          require('ts_context_commentstring.internal').update_commentstring()
        end,
      })
    end,
  }

  -- Brackets
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end,
  }

  -- Emmet
  use {
    'mattn/emmet-vim',
    key = { { 'i', '<C-z>', } },
    setup = function()
      vim.g.user_emmet_leader_key = '<C-z>'
    end,
  }

  -- Git
  use {
    'tpope/vim-fugitive',
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>gs', ':vert Git<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ga', ':Gwrite<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gm', ':GRename ', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gR', ':GRemove<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gb', ':Gblame<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gl', ':Glog<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gw', ':GBrowse<CR>', { noremap = true, silent = true })
    end,
    requires = {
      { 'tpope/vim-rhubarb', },
    },
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'GitGutterAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitGutterChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitGutterChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
      }
    end,
    requires = {
      { 'nvim-lua/plenary.nvim', },
    },
  }

  -- Markdown
  use {
    'npxbr/glow.nvim',
    cmd = { 'Glow', },
    setup = function()
      vim.api.nvim_set_keymap('n', '<leader>p', ':Glow<CR>', { noremap = true, silent = true })
    end,
  }

  use {
    'mattn/vim-maketable',
    cmd = { 'MakeTable', 'UnmakeTable', },
    setup = function()
      vim.api.nvim_set_keymap('x', '<leader>tt', ':MakeTable!<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tu', ':UnmakeTable<CR>', { noremap = true, silent = true })
    end,
  }

  --[[
  ------------------------------------------------------------------------
  |                              Appearance                              |
  ------------------------------------------------------------------------
  --]]

  -- colorscheme
  use { 'kyazdani42/blue-moon', opt = true, }

  -- statusline
  use {
    'hoob3rt/lualine.nvim',
    event = 'VimEnter',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'nightfly',
        },
        extensions = { 'fugitive', 'nvim-tree' }
      }
    end,
    requires = {
      { 'kyazdani42/nvim-web-devicons', },
    },
  }

  -- bufferline
  use {
    'akinsho/nvim-bufferline.lua',
    event = 'VimEnter',
    setup = require('plugins.bufferline').setup,
    config = require('plugins.bufferline').config,
    requires = {
      { 'kyazdani42/nvim-web-devicons', },
    },
  }

  -- Indent
  use {
    'glepnir/indent-guides.nvim',
    config = function()
      require('indent_guides').setup {
        indent_guides_auto_colors = 1,
      }
    end,
  }

  -- coloring RGBcode
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return plugins
