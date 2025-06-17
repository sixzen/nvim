SIGNS = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = SIGNS.Error,
      [vim.diagnostic.severity.WARN] = SIGNS.Warn,
      [vim.diagnostic.severity.HINT] = SIGNS.Hint,
      [vim.diagnostic.severity.INFO] = SIGNS.Info,
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
  virtual_text = false,
  -- virtual_text = {
  --   prefix = "●",
  -- },
  -- virtual_lines = true,
  update_in_insert = false,
  float = {
    source = true, -- Or "if_many"
    -- border = "rounded"
  },
}

-- vim.diagnostic.config {
--   virtual_text = false,
--   update_in_insert = false,
--   virtual_lines = true,
--   float = {
--     source = "always", -- Or "if_many"
--     border = "rounded"
--   },
-- }
