return {
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   event = "BufRead",
  --   opts = {
  --     override = {},
  --     default = true,
  --   },
  -- }, -- File icons
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  { "mbbill/undotree",   keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>" } } },
  {
    "tpope/vim-dispatch",
    cmd = { "Make", "Dispatch" },
  },
  { "tpope/vim-repeat",  event = "BufRead" },
  { "tpope/vim-rhubarb", event = "BufRead" },
  { "tpope/vim-dotenv",  event = "BufRead" },
  { "tpope/vim-eunuch",  event = "BufRead" },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        winblend = 0,
      },
    },
  },
  {
    "axelvc/template-string.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
    opts = {
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" }, -- filetypes where the plugin is active
      jsx_brackets = true,                                                                        -- must add brackets to jsx attributes
      remove_template_string = false,                                                             -- remove backticks when there are no template string
      restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [[']],
        jsx = [["]],
      },
    },
  },
  { "folke/todo-comments.nvim", event = "BufRead", dependencies = "nvim-lua/plenary.nvim", config = true },
  {
    "rmagatti/alternate-toggler",
    keys = "<leader>ta",
    config = function()
      vim.keymap.set("n", "<leader>ta", "<cmd>ToggleAlternate<cr>")
    end,
  },
  -- { "SmiteshP/nvim-navic",      lazy = true }, -- Breadcrumb
}
