return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante", "quarto" },
  opts = {
    code = {
      conceal_delimiters = false,
    },
    file_types = { "markdown", "Avante", "quarto" },
    completions = { lsp = { enabled = true } },
    win_options = {
      conceallevel = {
        default = 0,
      },
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
}
