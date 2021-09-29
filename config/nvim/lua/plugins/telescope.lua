local M = {}

--[[ Custom Pickers ]]

function M.edit_nvim_config()
  require("telescope.builtin").find_files({
    find_command = M._find_command,
    prompt_title = "~ nvim config ~",
    path_display = { "absolute" },
    cwd = "~/.config/nvim",

    file_ignore_patterns = { "lsp/" },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65 },
  })
end

function M.edit_zsh_config()
  require("telescope.builtin").find_files({
    find_command = M._find_command,
    prompt_title = "~ zsh config ~",
    path_display = { "absolute" },
    cwd = "~/.config/zsh",

    file_ignore_patterns = {
      ".zcompdump",
      ".zcompcache",
      ".*.zwc",
      ".zcompcache",
      ".zinit",
      ".zsh_sessions",
      ".p10k.zsh",
    },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
  })
end

function M.edit_dotfiles()
  require("telescope.builtin").find_files({
    find_command = M._find_command,
    prompt_title = "~ dotfiles ~",
    path_display = { "absolute" },
    cwd = "~/dotfiles",

    file_ignore_patterns = {},
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
  })
end

function M.fd()
  require("telescope.builtin").find_files({
    find_command = M._find_command,
    path_display = { "absolute" },
  })
end

function M.grep_string()
  require("telescope.builtin").grep_string({
    path_display = { "shorten" },
    file_ignore_patterns = { "packer_compiled.lua" },
    search = vim.fn.input("Grep String > "),
  })
end

function M.grep_under_cursor()
  require("telescope.builtin").grep_string({
    path_display = { "shorten" },
    file_ignore_patterns = { "packer_compiled.lua" },
  })
end

function M.live_grep()
  require("telescope").extensions.fzf_writer.staged_grep({
    path_display = { "shorten" },
    file_ignore_patterns = { "packer_compiled.lua" },
  })
end

function M.file_browser()
  require("telescope.builtin").file_browser({
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
  })
end

function M.buffers()
  require("telescope.builtin").buffers({
    path_display = { "absolute" },
  })
end

function M.oldfiles()
  require("telescope").extensions.frecency.frecency()
end

function M.help_tags()
  require("telescope.builtin").help_tags({ show_version = true })
end

function M.current_buffer_fuzzy_find()
  require("telescope.builtin").current_buffer_fuzzy_find({
    border = true,
    path_display = { "absolute" },
  })
end

function M.gh_issues()
  require("telescope").extensions.gh.issues()
end
function M.gh_pull_request()
  require("telescope").extensions.gh.pull_request()
end
function M.gh_gist()
  require("telescope").extensions.gh.gist()
end
function M.gh_run()
  require("telescope").extensions.gh.run()
end

function M.ghq_list()
  require("telescope").extensions.ghq.list()
end

M.pickers = setmetatable({}, {
  __index = function(_, key)
    if M[key] then
      return M[key]
    else
      return require("telescope.builtin")[key]
    end
  end,
})

--[[ Setup ]]

function M.setup()
  -- find command
  local ignore_globs = {
    "images",
    "img",
    "*.min.*",
    ".git",
    "node_modules",
    ".cache",
    ".DS_Store",
    ".localized",
  }
  local find_cmd, find_all_cmd
  if vim.fn.executable("fd") then
    find_cmd = { "fd", ".", "--hidden", "--follow", "--type", "f" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--exclude")
      table.insert(find_cmd, x)
    end
  elseif vim.fn.executable("rg") then
    find_cmd = { "rg", "--hidden", "--follow", "--files" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--glob=!" .. x)
    end
  end

  M._find_command = find_cmd
  M._find_all_command = find_all_cmd
end

--[[ Config ]]

function M.config()
  vim.cmd([[packadd telescope-fzf-writer.nvim]])
  vim.cmd([[packadd telescope-fzy-native.nvim]])
  vim.cmd([[packadd telescope-frecency.nvim]])
  vim.cmd([[packadd sql.nvim]])
  vim.cmd([[packadd telescope-github.nvim]])
  vim.cmd([[packadd telescope-ghq.nvim]])

  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local sorters = require("telescope.sorters")

  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--follow",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },

      layout_config = {
        prompt_position = "bottom",
      },

      file_sorter = sorters.get_fzy_sorter,

      mappings = {
        n = {
          ["q"] = actions.close,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
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
        ignore_patterns = { "*.git/*", "*/tmp/*", "*/build/*" },
        show_scores = true,
        show_unindexed = true,
        workspaces = {
          ["conf"] = vim.env.XDG_CONFIG_HOME,
          ["data"] = vim.env.XDG_DATA_HOME,
        },
      },
    },
  })

  telescope.load_extension("fzy_native")
  telescope.load_extension("frecency")
  telescope.load_extension("gh")
  telescope.load_extension("ghq")

  -- Mappings
  local set_keymap = function(key, f, options, buffer)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('plugins.telescope').pickers['%s'](%s)<CR>",
      f,
      options and vim.inspect(options, { newline = "" }) or ""
    )
    local map_opts = { noremap = true, silent = true }
    if buffer then
      vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_opts)
    else
      vim.api.nvim_set_keymap(mode, key, rhs, map_opts)
    end
  end

  local map_extension = function(key, e, f, options)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('telescope').extensions['%s']['%s'](%s)<CR>",
      e,
      f,
      options and vim.inspect(options, { newline = "" }) or ""
    )
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
  end

  -- Command line
  vim.api.nvim_set_keymap("c", "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { nowait = true })

  -- File Pickers
  set_keymap("<leader>cn", "edit_nvim_config")
  set_keymap("<leader>cz", "edit_zsh_config")
  set_keymap("<leader>cd", "edit_dotfiles")

  set_keymap("<leader>fd", "fd")
  set_keymap("<leader>fG", "grep_string")
  set_keymap("<leader>f*", "grep_under_cursor")
  set_keymap("<leader>fg", "live_grep")
  set_keymap("<leader>fe", "file_browser")

  -- Vim Pickers
  set_keymap("<leader>fb", "buffers")
  set_keymap("<leader>fo", "oldfiles")
  set_keymap("<leader>fh", "help_tags")
  set_keymap("<leader>ff", "current_buffer_fuzzy_find")

  -- Git Pickers
  set_keymap("<leader>gc", "git_commits", { initial_mode = "normal" })
  set_keymap("<leader>gC", "git_bcommits", { initial_mode = "normal" })
  set_keymap("<leader>gb", "git_branches", { initial_mode = "normal" })
  set_keymap("<leader>gs", "git_status", { initial_mode = "normal" })
  set_keymap("<leader>gS", "git_stash", { initial_mode = "normal" })

  -- GitHub Pickers
  set_keymap("<leader>gi", "gh_issues")
  set_keymap("<leader>gp", "gh_pull_request")
  set_keymap("<leader>gg", "gh_gist")
  set_keymap("<leader>gr", "gh_run")
  set_keymap("<leader>gq", "ghq_list")

  -- LSP Pickers
  set_keymap("<leader>lr", "lsp_references")
  set_keymap("<leader>la", "lsp_code_actions")
  set_keymap("<leader>ld", "lsp_definitions")
  set_keymap("<leader>ls", "lsp_document_symbols")
  set_keymap("<leader>lS", "lsp_workspace_symbols")
  set_keymap("<leader>ld", "lsp_document_diagnostics")
  set_keymap("<leader>lD", "lsp_workspace_diagnostics")

  -- Treesitter Pickers
  set_keymap("<leader>ft", "treesitter")

  -- dap
  map_extension("<Space>dc", "dap", "commands")
  map_extension("<Space>dC", "dap", "configurations")
  map_extension("<Space>dl", "dap", "list_breakpoints")
  map_extension("<Space>dv", "dap", "variables;")
end

return M
