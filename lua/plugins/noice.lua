return {
  "folke/noice.nvim",
  event = "UIEnter",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- {
    --   "rcarriga/nvim-notify",
    --   config = function()
    --     local notify = require "notify"
    --     notify.setup {
    --       stages = "fade_in_slide_out",
    --       render = "compact",
    --     }
    --   end,
    -- },
  },
  config = function()
    require("noice").setup {
      cmdline = { view = "cmdline" },
      popupmenu = { enabled = false },
      lsp = {
        progress = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = false,
          },
        },
        hover = {
          silent = true,
        }
      },
      notify = { enabled = false },
      presets = {
        bottom_search = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
      throttle = 42,
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
      views = {
        split = {
          enter = true,
          size = "25%",
          win_options = { signcolumn = "no", number = false, relativenumber = false, list = false, wrap = false },
        },
        -- popup = {
        -- border = "rounded",
        -- },
        hover = {
          border = "solid",
          position = { row = 2, col = 2 },
          win_options = {
            winhighlight = {
              Normal = "FloatHover",
              FloatBorder = "FloatBorderHover",
            },
          },
        },
        mini = {
          timeout = 3000,
          position = { row = -2 },
          border = "none",
          win_options = { winblend = 10 },
        },
        cmdline_popup = {
          border = "none",
        },
        confirm = {
          border = "none",
        },
        -- cmdline = {
        --   win_options = { winblend = 10 },
        -- },
      },
    }
  end,
}
