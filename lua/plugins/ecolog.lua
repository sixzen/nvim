return {
  "philosofonusus/ecolog.nvim",
  dependencies = {
    "hrsh7th/nvim-cmp", -- Optional: for autocompletion support (recommended)
  },
  -- Optional: you can add some keybindings
  -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
  keys = {
    { "<leader>ge", "<cmd>EcologGoto<cr>",          desc = "Go to env file" },
    { "<leader>vp", "<cmd>EcologPeek<cr>",          desc = "Ecolog peek variable" },
    { "<leader>vs", "<cmd>EcologSelect<cr>",        desc = "Switch env file" },
    { "<leader>vv", "<cmd>EcologSnacks<cr>",        desc = "Select env var" },
    { "<leader>vt", "<cmd>EcologShelterToggle<cr>", desc = "Ecolog shelter toggle" },
  },
  -- Lazy loading is done internally
  lazy = false,
  opts = {
    integrations = {
      blink_cmp = true,
      snacks = true,
    },
    -- Enables shelter mode for sensitive values
    shelter = {
      configuration = {
        -- Partial mode configuration:
        -- false: completely mask values (default)
        -- true: use default partial masking settings
        -- table: customize partial masking
        -- partial_mode = false,
        -- or with custom settings:
        partial_mode = {
          show_start = 1,
          show_end = 1,
          min_mask = 5,
        },
        mask_char = "*",       -- Character used for masking
        skip_comments = false, -- Skip masking comment lines in environment files (default: false)
      },
      modules = {
        cmp = true,                  -- Enabled to mask values in completion
        peek = false,                -- Enable to mask values in peek view
        files = {
          shelter_on_leave = true,   -- Control automatic re-enabling of shelter when leaving buffer
          disable_cmp = true,        -- Disable completion in sheltered buffers (default: true)
        },
        telescope = false,           -- Enable to mask values in telescope integration
        telescope_previewer = false, -- Enable to mask values in telescope preview buffers
        fzf = false,                 -- Enable to mask values in fzf picker
        fzf_previewer = false,       -- Enable to mask values in fzf preview buffers
        snacks_previewer = true,     -- Enable to mask values in snacks previewer
        snacks = true,               -- Enable to mask values in snacks picker
      },
    },
    -- true by default, enables built-in types (database_url, url, etc.)
    types = true,
    path = vim.fn.getcwd(),          -- Path to search for .env files
    preferred_environment = "local", -- Optional: prioritize specific env files
    -- Controls how environment variables are extracted from code and how cmp works
    provider_patterns = true,        -- true by default, when false will not check provider patterns
  },
}
