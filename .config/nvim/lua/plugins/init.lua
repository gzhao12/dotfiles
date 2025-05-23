return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    event = { 'VeryLazy' }
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", { noremap = true}, desc = "Toggle Dap UI" },
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { noremap = true }, desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", { noremap = true }, desc = "Continue Debug" },
      { "<leader>dr", "<cmd>lua require('dapui').open({reset = true})<cr>", { noremap = true }, desc = "Reset Dap UI" },
    }
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" }
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", "microsoft/debugpy" }
  },

}
