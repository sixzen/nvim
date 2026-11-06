return {
  "echasnovski/mini.diff",
  version = false,
  event = "VeryLazy",
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
    },
  },
  opts = {
    view = { overlay_style = "hunk" },
  },
}
