return {
  "nvim-neorg/neorg",
  -- build = ":Neorg sync-parsers",
  enabled = false,
  keys = {
    { "<leader>no", "<cmd>Neorg index<cr>", desc = "Neorg" },
  },
  cmd = { "Neorg" },
  version = "*",
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {
        config = {
          init_open_folds = "never",
        },
      },                  -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
    },
  },
}
