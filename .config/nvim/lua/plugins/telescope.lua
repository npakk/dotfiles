local M = {}

  --[[
  ------------------------------------------------------------------------
  |                          Custom Pickers                              |
  ------------------------------------------------------------------------
  --]]
function M.fd()
  require('telescope.builtin').find_files { find_command = M._find_command }
end

function M.grep_string()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    file_ignore_patterns = { 'packer_compiled.lua' },
    search = vim.fn.input('Grep String > '),
  }
end

function M.grep_under_cursor()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    file_ignore_patterns = { 'packer_compiled.lua' },
  }
end

function M.live_grep()
  require('telescope').extensions.fzf_writer.staged_grep {
    shorten_path = true,
    file_ignore_patterns = { 'packer_compiled.lua' },
  }
end

function M.file_browser()
  require('telescope.builtin').file_browser {
    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
  }
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.oldfiles() require('telescope').extensions.frecency.frecency() end

function M.help_tags()
  require('telescope.builtin').help_tags { show_version = true }
end

function M.current_buffer_fuzzy_find()
  require('telescope.builtin').current_buffer_fuzzy_find {
    border = true,
    shorten_path = false,
  }
end

function M.gh_issues() require('telescope').extensions.gh.issues() end
function M.gh_pull_request() require('telescope').extensions.gh.pull_request() end
function M.gh_gist() require('telescope').extensions.gh.gist() end
function M.gh_run() require('telescope').extensions.gh.run() end

function M.ghq_list() require('telescope').extensions.ghq.list() end

M.pickers = setmetatable({}, {
  __index = function(_, key)
    if M[key] then
      return M[key]
    else
      return require('telescope.builtin')[key]
    end
  end,
})

  --[[
  ------------------------------------------------------------------------
  |                              Setup                                   |
  ------------------------------------------------------------------------
  --]]
function M.setup()
  -- find command
  local ignore_globs = {
    'images',
    'img',
    '*.min.*',
    '.git',
    'node_modules',
    '.cache',
    '.DS_Store',
    '.localized',
  }
  local find_cmd, find_all_cmd
  if vim.fn.executable('fd') then
    find_cmd = { 'fd', '.', '--hidden', '--follow', '--type', 'f' }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, '--no-ignore')
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, '--exclude')
      table.insert(find_cmd, x)
    end
  elseif vim.fn.executable('rg') then
    find_cmd = { 'rg', '--hidden', '--follow', '--files' }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, '--no-ignore')
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, '--glob=!' .. x)
    end
  end

  M._find_command = find_cmd
  M._find_all_command = find_all_cmd

end

  --[[
  ------------------------------------------------------------------------
  |                              Config                                  |
  ------------------------------------------------------------------------
  --]]
function M.config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local sorters = require('telescope.sorters')

  telescope.setup{
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--hidden',
        '--follow',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      file_sorter = sorters.get_fzy_sorter,

      mappings = {
        n = {
          ['q'] = actions.close,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,
        },
      },
    },

    extensions = {
      fzf_writer = {
        minimum_grep_characters = 3,
        minimum_files_characters = 3,
      },

      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },

      frecency = {
        ignore_patterns = { '*.git/*', '*/tmp/*', '*/build/*' },
        show_scores = true,
        show_unindexed = true,
        workspaces = {
          ['conf'] = vim.env.XDG_CONFIG_HOME,
          ['data'] = vim.env.XDG_DATA_HOME,
        },
      },
    },
  }

  telescope.load_extension('fzy_native')
  telescope.load_extension('frecency')
  telescope.load_extension('gh')
  telescope.load_extension('ghq')

  -- File Pickers
  vim.api.nvim_set_keymap('n', '<leader>fd', "<cmd>lua require('plugins.telescope').pickers['fd']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fG', "<cmd>lua require('plugins.telescope').pickers['grep_string']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>f*', "<cmd>lua require('plugins.telescope').pickers['grep_under_cursor']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('plugins.telescope').pickers['live_grep']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fe', "<cmd>lua require('plugins.telescope').pickers['file_browser']()<CR>", { noremap = true, silent = true })

  -- Vim Pickers
  vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('plugins.telescope').pickers['buffers']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fo', "<cmd>lua require('plugins.telescope').pickers['oldfiles']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fh', "<cmd>lua require('plugins.telescope').pickers['help_tags']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('plugins.telescope').pickers['current_buffer_fuzzy_find']()<CR>", { noremap = true, silent = true })

  -- Git Pickers
  vim.api.nvim_set_keymap('n', '<leader>ggc', "<cmd>lua require('plugins.telescope').pickers['git_commits']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggC', "<cmd>lua require('plugins.telescope').pickers['git_bcommits']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggb', "<cmd>lua require('plugins.telescope').pickers['git_branches']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggs', "<cmd>lua require('plugins.telescope').pickers['git_status']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggS', "<cmd>lua require('plugins.telescope').pickers['git_stash']()<CR>", { noremap = true, silent = true })

  -- GitHub Pickers
  vim.api.nvim_set_keymap('n', '<leader>ggi', "<cmd>lua require('plugins.telescope').pickers['gh_issues']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggp', "<cmd>lua require('plugins.telescope').pickers['gh_pull_request']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggg', "<cmd>lua require('plugins.telescope').pickers['gh_gist']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggr', "<cmd>lua require('plugins.telescope').pickers['gh_run']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>ggq', "<cmd>lua require('plugins.telescope').pickers['ghq_list']()<CR>", { noremap = true, silent = true })

  -- LSP Pickers
  vim.api.nvim_set_keymap('n', '<leader>flr', "<cmd>lua require('plugins.telescope').pickers['lsp_references']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fla', "<cmd>lua require('plugins.telescope').pickers['lsp_code_actions']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fld', "<cmd>lua require('plugins.telescope').pickers['lsp_definitions']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fls', "<cmd>lua require('plugins.telescope').pickers['lsp_document_symbols']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>flS', "<cmd>lua require('plugins.telescope').pickers['lsp_workspace_symbols']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>fld', "<cmd>lua require('plugins.telescope').pickers['lsp_document_diagnostics']()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>flD', "<cmd>lua require('plugins.telescope').pickers['lsp_workspace_diagnostics']()<CR>", { noremap = true, silent = true })

  -- Treesitter Pickers
  vim.api.nvim_set_keymap('n', '<leader>ft', "<cmd>lua require('plugins.telescope').pickers['treesitter']()<CR>", { noremap = true, silent = true })
end

return M
