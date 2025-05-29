return {
  "neovim/nvim-lspconfig", -- LSP
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "SmiteshP/nvim-navic", -- Breadcrumb
    -- "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    -- {
    --   "folke/neodev.nvim",
    --   opts = {}
    -- },
    -- {
    --   "antosha417/nvim-lsp-file-operations",
    --   config = true,
    -- },
    -- {
    --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --   config = function()
    --     require("lsp_lines").setup()
    --
    --     local opts = { noremap = true, silent = true }
    --     vim.keymap.set("", "<leader>ls", require("lsp_lines").toggle, opts)
    --   end,
    -- },
    -- {
    --   "j-hui/fidget.nvim", -- LSP progress
    --   dependencies = {
    --     "rcarriga/nvim-notify",
    --   },
    --   opts = {
    --     progress = {
    --       notification_group = function(msg)
    --         return msg.lsp_client.name
    --       end,
    --       ignore = { "null-ls", "copilot" }, -- List of LSP servers to ignore
    --     },
    --   },
    -- },
  },
  main = "sixzen.lsp",
  config = true,
}
