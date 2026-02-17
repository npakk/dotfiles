return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("ruby-lsp", {
        cmd_env = { BUNDLE_GEMFILE = "Gemfile.local" },
        cmd = { "bundle", "exec", "ruby-lsp" },
        filetypes = { "ruby", "eruby" },
        -- root_markers = { "Gemfile", ".git" },
        init_options = {
          -- enabledFeatures = {
          --   diagnostics = false,
          --   formatting = false,
          -- },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      })
      vim.lsp.enable("ruby-lsp")

      -- local version_output = vim.fn.system("bundle exec rubocop -V")
      -- local version = version_output:match("rubocop (%d+%.%d+)")
      -- -- バージョンが1.53以上なら
      -- if version and tonumber(version) >= 1.53 then
      --   vim.lsp.config("rubocop", {
      --     cmd = { "bundle", "exec", "rubocop", "--lsp" },
      --   })
      --   vim.lsp.enable("rubocop")
      -- end

      vim.lsp.config("lua_ls", {
        -- on_attach = function(client, bufnr)
        --   client.server_capabilities.documentFormattingProvider = false
        --   client.handlers["textDocument/publishDiagnostics"] = function() end
        -- end,
        settings = {
          Lua = {
            diagnostics = {
              enable = false,
              globals = { "vim" },
            },
            format = {
              enable = false,
            },
          },
        },
      })
      -- vim.lsp.enable("lua_ls")

      vim.lsp.config("pyright", {
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
      -- vim.lsp.enable("pyright")

      vim.lsp.config("ruff", {
        capabilities = {
          general = {
            positionEncodings = { "utf-16" },
          },
        },
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end,
      })
      -- vim.lsp.enable("ruff")

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
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "neovim/nvim-lspconfig" },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      { "mason-org/mason.nvim" },
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
        if package.name ~= "ruff" then
          local package_categories = package.spec.categories[1]
          if package_categories == mason_package.Cat.Formatter then
            table.insert(null_sources, null_ls.builtins.formatting[package.name])
          end
          if package_categories == mason_package.Cat.Linter then
            table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
          end
        end
      end

      -- format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = null_sources,
        on_attach = function(_, bufnr)
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
