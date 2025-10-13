return {
  "olexsmir/gopher.nvim",
  ft = "go",
  keys = {
    { "<leader>cgj", "<cmd>GoTagAdd json<CR>", desc = "Go add JSON tags" },
    { "<leader>cgd", "<cmd>GoTagAdd db<CR>", desc = "Go add DB tags" },
    { "<leader>cgy", "<cmd>GoTagAdd yaml<CR>", desc = "Go add YAML tags" },
  },
  config = function()
    local gopher = require "gopher"
    gopher.setup {}
  end,
  build = function()
    vim.cmd [[silent! GoInstallDeps]]
  end,
}
