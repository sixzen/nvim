return {
  {
    "zbirenbaum/copilot.lua",
    event = "BufReadPost",
    dependencies = {
      -- "copilotlsp-nvim/copilot-lsp",
      -- init = function()
      --   vim.g.copilot_nes_debounce = 500
      -- end,
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          vim.b.copilot_suggestion_hidden = true
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      should_attach = function(_, bufname)
        if string.match(bufname, "env") then
          return false
        end

        return true
      end,
    },
  },
  -- {
  --   "github/copilot.vim",
  -- }
}
