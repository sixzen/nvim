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
  },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon"
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
      autosave_changes = false,
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
