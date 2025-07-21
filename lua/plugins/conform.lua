return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
    {
      "<leader>cF",
      function()
        require("conform").format { formatters = { "injected" }, timeout_ms = 3000 }
      end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = "fallback", -- not recommended to change
    },
    formatters_by_ft = {
      lua = { "stylua", lsp_format = "fallback" },
      json = { "jq" },
      python = { "ruff", "isort", "black" },
      ["markdown"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find "<!%-%- toc %-%->" then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
    },
  },
}
