---@type vim.lsp.Config
return {
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace", -- openFilesOnly, workspace
        typeCheckingMode = "basic", -- off, basic, strict
        useLibraryCodeForTypes = true,
      },
    },
  },
  root_markers = {
    ".git",
    "setup.py",
    "setup.cfg",
    "pyproject.toml",
    "requirements.txt",
  },
}
