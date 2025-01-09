local trigger_text = ";"
return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    dependencies = {
      "saadparwaiz1/cmp_luasnip", --cmp luasnip
      "hrsh7th/cmp-path",         -- nvim-cmp buffer for paths
      "hrsh7th/cmp-buffer",       -- nvim-cmp source for buffer words
      "hrsh7th/cmp-nvim-lsp",     -- nvim-cmp source for neovim',s built-in LSP
      "hrsh7th/cmp-nvim-lua",     -- nvim-cmp for lua
      "hrsh7th/cmp-git",          -- nvim-cmp for git
      "hrsh7th/cmp-cmdline",      -- nvim-cmp for cmdline
      "hrsh7th/cmp-emoji",        -- nvim-cmp source for emojis
      "L3MON4D3/LuaSnip",         -- Snippets
      {
        "js-everts/cmp-tailwind-colors",
        opts = {
          enable_alpha = false,
          format = function(itemColor)
            return {
              fg = itemColor,
              bg = nil, -- or nil if you dont want a background color
              text = " ", -- or use an icon
            }
          end,
        },
      },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp = require "cmp"
      local cmp_mapping = require "cmp.config.mapping"
      local icons = require "sixzen.icons"
      local cmp_types = require "cmp.types.cmp"
      local ConfirmBehavior = cmp_types.ConfirmBehavior
      local SelectBehavior = cmp_types.SelectBehavior
      local luasnip = require "luasnip"

      cmp.setup {
        experimental = {
          native_menu = false,
          ghost_text = false,
        },
        window = {
          completion = {
            winhighlight = "Normal:CmpNormal",
          },
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find "^_+"
              local _, entry2_under = entry2.completion_item.label:find "^_+"
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        mapping = cmp_mapping.preset.insert {
          ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = SelectBehavior.Select }, { "i" }),
          ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = SelectBehavior.Select }, { "i" }),
          ["<C-d>"] = cmp_mapping.scroll_docs(-4),
          ["<C-u>"] = cmp_mapping.scroll_docs(4),
          ["<C-y>"] = cmp_mapping {
            i = cmp_mapping.confirm { behavior = ConfirmBehavior.Insert, select = true },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = ConfirmBehavior.Insert, select = true }
              else
                fallback()
              end
            end,
          },
          ["<C-n>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item { behavior = SelectBehavior.Select }
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              cmp_mapping.complete()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = SelectBehavior.Select }
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp_mapping.complete(),
          ["<C-e>"] = cmp_mapping.abort(),
        },
        sources = cmp.config.sources {
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "render-markdown" },
          { name = "emoji" },
          {
            name = "buffer",
            keyword_length = 3,
            option = {
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
          { name = "path" },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          max_width = 0,
          kind_icons = icons.kind,
          source_names = {
            nvim_lsp = "(LSP)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            vsnip = "(Snippet)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
            tmux = "(TMUX)",
            copilot = "(Copilot)",
            treesitter = "(TreeSitter)",
            neorg = "(Neorg)",
          },
          duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
          },
          duplicates_default = 0,
          format = function(entry, vim_item)
            local max_width = 0
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end

            vim_item.menu = vim_item.kind
            vim_item = require("cmp-tailwind-colors").format(entry, vim_item)
            if icons.kind[vim_item.kind] then
              vim_item.kind = icons.kind[vim_item.kind] .. " "
            end

            if entry.source.name == "copilot" then
              vim_item.kind = icons.git.Octoface
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            if entry.source.name == "cmp_tabnine" then
              vim_item.kind = icons.misc.Robot
              vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "crates" then
              vim_item.kind = icons.misc.Package
              vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "lab.quick_data" then
              vim_item.kind = icons.misc.CircuitBoard
              vim_item.kind_hl_group = "CmpItemKindConstant"
            end

            if entry.source.name == "emoji" then
              vim_item.kind = icons.misc.Smiley
              vim_item.kind_hl_group = "CmpItemKindEmoji"
            end
            local source_names = {
              nvim_lsp = "(LSP)",
              emoji = "(Emoji)",
              path = "(Path)",
              calc = "(Calc)",
              cmp_tabnine = "(Tabnine)",
              vsnip = "(Snippet)",
              luasnip = "(Snippet)",
              buffer = "(Buffer)",
              tmux = "(TMUX)",
              copilot = "(Copilot)",
              treesitter = "(TreeSitter)",
              neorg = "(Neorg)",
            }
            local duplicates = {
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 1,
            }
            vim_item.menu = source_names[entry.source.name]
            vim_item.dup = duplicates[entry.source.name] or 0
            return vim_item
          end,
        },
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
        }, {
          { name = "buffer" },
        }),
      })

      vim.api.nvim_set_hl(0, "CmpItemKind", { link = "CmpItemMenuDefault" })
    end,
  },
  {
    -- inspired by https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/blink-cmp.lua
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", "moyiz/blink-emoji.nvim" },
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    version = "v0.*",
    opts = {
      keymap = { preset = "default" },

      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        -- documentation = {
        --   auto_show = true,
        --   auto_show_delay_ms = 200,
        -- },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = require("sixzen.icons").kind,
      },

      sources = {
        default = { "lazydev", "lsp", "path", "buffer", "dadbod", "markdown", "snippets", "emoji" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            -- kind = "LSP",
            score_offset = 90, -- the higher the number, the higher the priority
          },
          snippets = {
            name = "snippets",
            enabled = true,
            module = "blink.cmp.sources.snippets",
            min_keyword_length = 2,
            -- fallbacks = { "snippets" },
            score_offset = 95,
            max_items = 8,
            should_show_items = function()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              return before_cursor:match(trigger_text .. "%w*$") ~= nil
            end,
            transform_items = function(ctx, items)
              local _ = ctx
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
              if trigger_pos then
                for _, item in ipairs(items) do
                  item.textEdit = {
                    newText = item.insertText or item.label,
                    range = {
                      start = { line = vim.fn.line "." - 1, character = trigger_pos - 1 },
                      ["end"] = { line = vim.fn.line "." - 1, character = col },
                    },
                  }
                end
              end
              vim.schedule(function()
                require("blink.cmp").reload "snippets"
              end)
              return items
            end,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,        -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 3,
            fallbacks = { "snippets", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 3,
          },
          -- snippets = {
          --   name = "snippets",
          --   enabled = true,
          --   max_items = 3,
          --   module = "blink.cmp.sources.snippets",
          --   min_keyword_length = 4,
          --   score_offset = 80, -- the higher the number, the higher the priority
          -- },
        },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" then
            return { "cmdline" }
          end
          return {}
        end,
      },
      snippets = {
        preset = "luasnip",
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },

      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}
