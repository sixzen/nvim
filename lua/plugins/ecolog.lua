return {
  "philosofonusus/ecolog.nvim",
  enabled = false,
  dependencies = {
    "hrsh7th/nvim-cmp", -- Optional: for autocompletion support (recommended)
  },
  -- Optional: you can add some keybindings
  -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
  keys = {
    { "<leader>ge", "<cmd>Ecolog files open_active<cr>", desc = "Go to env file" },
    { "<leader>vp", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
    { "<leader>vs", "<cmd>Ecolog files select<cr>", desc = "Switch env file" },
    { "<leader>vv", "<cmd>Ecolog list<cr>", desc = "Select env var" },
    { "<leader>vt", "<cmd>Ecolog shell<cr>", desc = "Ecolog shelter toggle" },
  },
  -- Lazy loading is done internally
  lazy = false,
  opts = {
    picker = {
      backend = "snacks", -- or "fzf" or "snacks"
    },
  },
}
