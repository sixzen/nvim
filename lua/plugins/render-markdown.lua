return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante" },
  opts = {
    file_types = { "markdown", "Avante" },
    win_options = {
      conceallevel = {
        default = 0,
      },
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}
