local lspUtils = require "sixzen.lsp.utils"
local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  table.concat({
    lspUtils.get_pkg_path("angular-language-server", "node_modules"),
    vim.fn.getcwd() .. "/node_modules",
  }, ","),
  "--ngProbeLocations",
  table.concat({
    lspUtils.get_pkg_path("angular-language-server", "node_modules/@angular/language-server/node_modules"),
    vim.fn.getcwd() .. "/node_modules",
  }, ","),
}

---@type vim.lsp.Config
return {
  cmd = cmd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
  root_markers = { "angular.json" },
}
