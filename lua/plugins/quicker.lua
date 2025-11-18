return {
  "stevearc/quicker.nvim",
  ft = "qf",
  keys = {
    {
      "<leader>qf",
      function()
        require("quicker").toggle()
      end,
      "Toggle quickfix",
    },
    {
      "<leader>ll",
      function()
        require("quicker").toggle { loclist = true }
      end,
      "Toggle loclist",
    },
  },
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    keys = {
      {
        ">",
        function()
          require("quicker").expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },
  },
}
