return {
  -- {
  --   "github/copilot.vim",
  --   event = "InsertEnter",
  -- },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
  },
  {
    "Wansmer/treesj",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = { { "<leader>j", "<cmd>TSJToggle<CR>", desc = "TreesJ" } },
    opts = { use_default_keymaps = false },
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = { check_ts = true, map_c_h = true },
  -- },
  -- {
  --   "numToStr/Comment.nvim",
  --   event = "BufReadPost",
  --   opts = {},
  -- },
  -- {
  --   "kylechui/nvim-surround",
  --   event = "BufReadPost",
  --   opts = {},
  --   --[[
  --      Old text                    Command         New text
  --  --------------------------------------------------------------------------------
  --      surr*ound_words             ysiw)           (surround_words)
  --      *make strings               ys$"            "make strings"
  --      [delete ar*ound me!]        ds]             delete around me!
  --      remove <b>HTML t*ags</b>    dst             remove HTML tags
  --      'change quot*es'            cs'"            "change quotes"
  --      <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  --      delete(functi*on calls)     dsf             function calls
  --  --]]
  -- },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "./snippets" },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind.nvim" },
      -- { "windwp/nvim-autopairs" },
      { "L3MON4D3/LuaSnip" },
    },
    event = { "InsertEnter" },
    config = function()
      -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup({
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = require("lspkind").presets.default[vim_item.kind]
            vim_item.menu = ({
              luasnip = "[LuaSnip]",
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              nvim_lua = "[Lua]",
              path = "[Path]",
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
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "path" },
        },
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", keyword_length = 2 },
        }),
      })
    end,
  },
}
