return {
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    event = "VeryLazy",
    keys = {
      {
        "<leader>cp",
        function()
          require("minty.huefy").open()
        end,
      },
    },
  },
}
