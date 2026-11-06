return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-mini/mini.icons" },
  keys = {
    {
      "-",
      "<CMD>Oil<CR>",
      desc = "Start oil",
    },
    {
      "<leader>e",
      function()
        require("oil").open_float(nil, { preview = {} })
      end,
      desc = "Oil float (directory of current file)",
    },
    {
      "<leader>E",
      function()
        require("oil").open_float(vim.uv.cwd(), { preview = {} })
      end,
      desc = "Oil float (cwd)",
    },
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
      { "size", highlight = "String" },
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
    float = {
      border = "solid",
      max_width = 150,
      win_options = {
        winblend = 10,
      },
    },
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    delete_to_trash = false,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = true,
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 1000,
      autosave_changes = true,
    },
    constrain_cursor = "editable",
    watch_for_changes = false,
    use_default_keymaps = true,
    view_options = {
      show_hidden = true,
      natural_order = "fast",
      case_insensitive = false,
    },
    preview_win = {
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
    },
  },
}
