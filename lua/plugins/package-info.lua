return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "VeryLazy",
  keys = {
    { "<leader>nt", function() require("package-info").toggle() end, desc = "Package info toggle" },
    { "<leader>nu", function() require("package-info").update() end, desc = "Package info update" },
    { "<leader>ni", function() require("package-info").install() end, desc = "Package info install" },
    { "<leader>nd", function() require("package-info").delete() end, desc = "Package info delete" },
  },
  config = function()
    require("package-info").setup {
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      package_manager = "pnpm",
    }
  end,
}
