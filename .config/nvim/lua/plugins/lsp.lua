return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig["ruby_lsp"].setup({
        cmd = { "bundle", "exec", "ruby-lsp" },
        cmd_env = { BUNDLE_GEMFILE = "Gemfile.local" },
        init_options = {
          enabledFeatures = {
            diagnostics = false,
            formatting = false,
          },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      })
      local version_output = vim.fn.system("bundle exec rubocop -V")
      local version = version_output:match("rubocop (%d+%.%d+)")
      -- バージョンが1.53以上なら
      if version and tonumber(version) >= 1.53 then
        lspconfig.rubocop.setup({
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local mason = require("mason")
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff",
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            handlers = {
              ["textDocument/publishDiagnostics"] = function() end,
              ["textDocument/formatting"] = function() end,
            },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            settings = {
              pyright = {
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  ignore = { "*" },
                },
              },
            },
          })
        end,
        ["ruff"] = function()
          lspconfig.ruff.setup({
            on_attach = function(client, bufnr)
              client.server_capabilities.hoverProvider = false
            end,
          })
        end,
      })

      -- diagnotics format
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
          end,
        },
        float = {
          format = function(diagnostic)
            return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
          end,
        },
      })

      -- format on save
      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvimtools/none-ls.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local mason_package = require("mason-core.package")
      local mason_registry = require("mason-registry")
      local null_ls = require("null-ls")

      require("mason-null-ls").setup({
        ensure_installed = {
          "selene",
          "stylua",
        },
      })

      -- set mason sources to null-ls
      local null_sources = {}

      for _, package in ipairs(mason_registry.get_installed_packages()) do
        if package.name == "ruff" then
          goto continue
        end
        local package_categories = package.spec.categories[1]
        if package_categories == mason_package.Cat.Formatter then
          table.insert(null_sources, null_ls.builtins.formatting[package.name])
        end
        if package_categories == mason_package.Cat.Linter then
          table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
        end
        ::continue::
      end

      -- format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = null_sources,
        on_attach = function(client, bufnr)
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      })
    end,
  },
}
