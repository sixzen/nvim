return {
  "ph1losof/shelter.nvim",
  lazy = false,
  config = function()
    require("shelter").setup {
      -- Appearance
      mask_char = "*",
      highlight_group = "Comment",

      -- Behavior
      skip_comments = false,
      default_mode = "partial", -- "full", "partial", "none", or custom
      env_filetypes = { "dotenv", "sh", "conf" },

      -- Module toggles
      modules = {
        files = {
          shelter_on_leave = true,
          disable_cmp = true,
        },
        telescope_previewer = false,
        fzf_previewer = false,
        snacks_previewer = true,
      },
    }
  end,
}
