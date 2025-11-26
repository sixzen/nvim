return {
  "A7Lavinraj/fyler.nvim",
  lazy = false,
  enabled = false,
  dependencies = { "nvim-mini/mini.icons" },
  opts = {
    hooks = {
      on_rename = function(src_path, destination_path)
        Snacks.rename.on_rename_file(src_path, destination_path)
      end,
    },
    views = {
      finder = {
        close_on_select = true,
        confirm_simple = true,
        default_explorer = true,
        delete_to_trash = false,
        icon = {
          directory_collapsed = nil,
          directory_empty = "󰷏",
          directory_expanded = "󰝰",
        },
        win = {
          win_opts = {
            cursorline = true,
            number = true,
            relativenumber = true,
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("fyler").toggle {}
      end,
      desc = "File Explorer (Fyler)",
    },
  },
}
