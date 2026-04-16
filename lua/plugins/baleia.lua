return {
  "m00qek/baleia.nvim",
  config = function()
    local baleia = require("baleia").setup({})

    -- Command to manually apply ANSI rendering in any buffer
    vim.api.nvim_create_user_command("BaleiaColorize", function()
      baleia.once(vim.api.nvim_get_current_buf())
    end, { bang = true })
  end,
}
