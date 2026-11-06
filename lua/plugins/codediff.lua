-- VS Code style diff, used to review uncommitted (agent) changes.
-- diffview.nvim stays as the merge/conflict tool (see git.lua).
return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>dv", "<cmd>CodeDiff<cr>", desc = "Toggle CodeDiff" },
    { "<leader>dh", "<cmd>CodeDiff history %<cr>", desc = "CodeDiff file history" },
    { "<leader>dH", "<cmd>CodeDiff history<cr>", desc = "CodeDiff repo history" },
  },
  init = function()
    vim.opt.fillchars:append "diff:╱"
  end,
  opts = {
    explorer = {
      width = 50,
      auto_open_on_cursor = true,
      view_mode = "tree",
      line_stats = { enabled = true },
    },
    diff = {
      compact = true,
      compact_context_lines = 8,
      compact_sync_folds = true,
    },
  },
  config = function(_, opts)
    require("codediff").setup(opts)

    -- Workaround for neovim/neovim#40290: the treesitter fold refresh on
    -- 'foldminlines' OptionSet does not check buffer validity. Compact mode
    -- sets that option on each file switch and crashes with "Invalid buffer id"
    -- once a diff buffer is wiped. Remove when fixed upstream.
    require "vim.treesitter._fold"
    for _, au in ipairs(vim.api.nvim_get_autocmds { event = "OptionSet" }) do
      if au.desc == "Refresh treesitter folds" then
        vim.api.nvim_del_autocmd(au.id)
      end
    end
  end,
}
