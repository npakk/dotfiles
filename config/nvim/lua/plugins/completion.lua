local M = {}

function M.setup() end

function M.config()
  -- references
  -- https://alpha2phi.medium.com/new-neovim-completion-plugins-you-should-try-b5e1a3661623

  vim.cmd([[packadd lspkind-nvim]])

  -- autopairs integration nvim-cmp
  require("nvim-autopairs.completion.cmp").setup({
    map_cr = true,
    map_complete = true,
    auto_select = true,
  })

  local cmp = require("cmp")

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
  end

  cmp.setup({
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = require("lspkind").presets.default[vim_item.kind]
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          vsnip = "[vsnip]",
          nvim_lua = "[Lua]",
          look = "[Look]",
          path = "[Path]",
          cmp_tabnine = "[TabNine]",
          calc = "[Calc]",
          spell = "[Spell]",
          emoji = "[Emoji]",
        })[entry.source.name]
        return vim_item
      end,
    },
    completion = {
      get_trigger_characters = function(trigger_characters)
        return vim.tbl_filter(function(char)
          return char ~= " "
        end, trigger_characters)
      end,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-n>"), "n")
        elseif vim.fn["vsnip#available"]() == 1 then
          vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)"), "")
        elseif check_back_space() then
          vim.fn.feedkeys(t("<Tab>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-p>"), "n")
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          vim.fn.feedkeys(t("<Plug>(vsnip-jump-prev)"), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = {
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "nvim_lua" },
      { name = "look" },
      { name = "path" },
      { name = "cmp_tabnine" },
      { name = "calc" },
      { name = "spell" },
      { name = "emoji" },
    },
  })
end

return M
