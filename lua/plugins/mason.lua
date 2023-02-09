return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local lspconfig = require("mason-lspconfig")

    mason.setup({})
    lspconfig.setup({
      ensure_installed = {},
    })
  end,
}
