return {
  "rcarriga/nvim-notify",
  event = "UIEnter",
  enabled = false,
  config = function()
    local notify = require "notify"
    notify.setup {
      stages = "fade_in_slide_out",
      render = "compact",
    }
    vim.notify = notify
  end,
}
