return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  enabled  = false,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-frecency.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      dependencies = {
        "junegunn/fzf.vim",
        dependencies = {
          {
            "tpope/vim-dispatch",
            cmd = { "Make", "Dispatch" },
          },
        },
      },
    },
    -- { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require "sixzen.telescope.setup"
    require "sixzen.telescope.mappings"
  end,
}
