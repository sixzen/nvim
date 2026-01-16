return {
  "nvim-treesitter/nvim-treesitter",
  -- event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    -- "numToStr/Comment.nvim",
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    -- {
    --   "windwp/nvim-autopairs",
    --   opts = {
    --     disable_filetype = { "TelescopePrompt", "vim" },
    --   },
    -- },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup {
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 6, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
          trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
        }
        -- vim.api.nvim_set_hl(0, "TreesitterContext", { link = "StatusLine" })
      end,
    },
  },
  opts = {},
  config = function()
    require("nvim-treesitter").install {
      "tsx",
      "lua",
      "json",
      "javascript",
      "typescript",
      "html",
      "css",
      "python",
      "http",
      "bash",
      "vimdoc",
      "go",
      "rust",
      "java",
      "markdown",
      "markdown_inline",
      "regex",
      "vim",
    }

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available_parsers = require("nvim-treesitter").get_available()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        local installed_parsers = require("nvim-treesitter").get_installed "parsers"

        if vim.tbl_contains(installed_parsers, language) then
          -- enable the parser if it is installed
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- if a parser is available in `nvim-treesitter` enable it after ensuring it is installed
          require("nvim-treesitter").install(language):await(function()
            treesitter_try_attach(buf, language)
          end)
        else
          -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
    })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      pattern = { "*.component.html", "*.container.html" },
      callback = function(args)
        local buf = args.buf
        vim.treesitter.start(buf, "angular")
      end,
    })
  end,
}
