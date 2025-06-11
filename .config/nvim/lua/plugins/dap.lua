return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "mfussenegger/nvim-dap",
        config = function()
          -- stylua: ignore start
          vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
          vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
          vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

          vim.fn.sign_define("DapBreakpoint",
            { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
          vim.fn.sign_define("DapBreakpointCondition",
            { text = "󰮍", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
          vim.fn.sign_define("DapBreakpointRejected",
            { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
          vim.fn.sign_define("DapLogPoint",
            { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" })
          vim.fn.sign_define("DapStopped",
            { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
          -- stylua: ignore end
          local dap = require("dap")
          dap.configurations.eruby = {
            {
              type = "ruby",
              request = "attach",
              options = { source_filetype = "eruby" },
              error_on_failure = true,
              localfs = true,
              name = "attach existing (port 38698)",
              port = 38698,
              waiting = 0,
            },
          }
        end,
      },
      {
        "suketa/nvim-dap-ruby",
        config = function()
          require("dap-ruby").setup()
        end,
      },
    },
    keys = {
      { "<leader>dd", "<cmd>lua require('dapui').toggle()<CR>", desc = "launch dapui" },
      { "<leader>de", "<cmd>lua require('dapui').eval()<CR>", desc = "dap eval" },
      { "<F5>", "<cmd>DapContinue<CR>", desc = "dap continue" },
      { "<F10>", "<cmd>DapStepOver<CR>", desc = "dap stepover" },
      { "<F11>", "<cmd>DapStepInto<CR>", desc = "dap stepinto" },
      { "<F12>", "<cmd>DapStepOut<CR>", desc = "dap stepout" },
      { "<leader>b", "<cmd>DapToggleBreakpoint<CR>", desc = "dap breakpoint" },
      {
        "<leader>B",
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '), nil, nil) <CR>",
        desc = "dap breakpoint condition",
      },
      {
        "<leader>L",
        "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        desc = "dap logpoint",
      },
      { "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", desc = "dap repl" },
      { "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", desc = "dap run last" },
    },
    config = function()
      require("dapui").setup()
    end,
  },
}
