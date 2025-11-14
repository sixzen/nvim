return {
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            return false
          end
          return true
        end,
      },
      should_attach = function(_, bufname)
        if not vim.bo.buflisted then
          return false
        end

        if vim.bo.buftype ~= "" then
          return false
        end

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
