return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    vim.diagnostic.open_float = require("tiny-inline-diagnostic.override").open_float
    require("tiny-inline-diagnostic").setup {
      options = {
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_source = {
          enabled = true,
          if_many = true,
        },
      },
    }
  end,
}
