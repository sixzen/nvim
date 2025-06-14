vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

-- Setup Workspace
local home = os.getenv "HOME"
local workspace_path = home .. "/.local/share/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

-- Determine OS
local os_config = "linux"
if vim.fn.has "mac" == 1 then
  os_config = "mac"
end

-- Setup Capabilities
-- local capabilities = require("sixzen.lsp").capabilities()
-- local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
-- extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

-- Setup Testing and Debugging
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
    "-data",
    workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  -- capabilities = capabilities,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          -- {
          --   name = "JavaSE-11",
          --   path = "~/.sdkman/candidates/java/11.0.2-open",
          -- },
          -- {
          --   name = "JavaSE-17",
          --   path = "~/.sdkman/candidates/java/17.0.11-oracle",
          -- },
          -- {
          --   name = "JavaSE-18",
          --   path = "~/.sdkman/candidates/java/18.0.1.1-open",
          -- },
          {
            name = "JavaSE-19",
            path = "~/.local/share/mise/installs/java/19.0.2",
          },
          {
            name = "JavaSE-20",
            path = "~/.local/share/mise/installs/java/20.0.2",
          },
          {
            name = "JavaSE-21",
            path = "~/.local/share/mise/installs/java/21.0.2",
          },
          {
            name = "JavaSE-22",
            path = "~/.local/share/mise/installs/java/22.0.2",
          },
          -- {
          --   name = "JavaSE-19",
          --   path = "~/.sdkman/candidates/java/19-open",
          -- },
          -- {
          --   name = "JavaSE-20",
          --   path = "~/.sdkman/candidates/java/20-open",
          -- },
          -- {
          --   name = "JavaSE-21",
          --   path = "~/.sdkman/candidates/java/21.0.2-open",
          -- },
          -- {
          --   name = "JavaSE-22",
          --   path = "~/.sdkman/candidates/java/22-open",
          -- },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
      signatureHelp = { enabled = true },
    },
  },
  init_options = {
    bundles = bundles,
    -- extendedClientCapabilities = extendedClientCapabilities,
  },
}

config["on_attach"] = function(client, bufnr)
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls").setup_dap { hotcodereplace = "auto" }
  -- require("sixzen.lsp").on_attach(client, bufnr)
  local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
  if status_ok then
    jdtls_dap.setup_dap_main_class_configs()
  end
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

require("jdtls").start_or_attach(config)
