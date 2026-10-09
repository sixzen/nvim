local notes_root = os.getenv "ORG_DIRECTORY"

return {
  "xheisenbugx/org.nvim",
  main = "org",
  lazy = false,
  enabled = notes_root ~= nil and notes_root ~= "",
  opts = function()
    return {
      org_directory = notes_root,
      agenda_files = { notes_root .. "/**/*.org" },
      default_notes_file = notes_root .. "/refile.org",
    }
  end,
}
