local trigger_text = ";"

local function execute_luasnip_with_trigger_prefix(trigger)
  return function(source, ctx, item)
    local luasnip = require "luasnip"
    local snip = luasnip.get_id_snippet(item.data.snip_id)

    if snip.regTrig then
      local docTrig = source.config.prefer_doc_trig and snip.docTrig
      snip = snip:get_pattern_expand_helper()

      if docTrig then
        local add_luasnip_callback = function(snippet, event, callback)
          local events = require "luasnip.util.events"
          if snippet.callbacks == nil then
            return
          end
          snippet.callbacks[-1] = snippet.callbacks[-1] or {}
          snippet.callbacks[-1][events[event]] = callback
        end

        add_luasnip_callback(snip, "pre_expand", function(snippet, _)
          if #snippet.insert_nodes == 0 then
            snippet.insert_nodes[0].static_text = { docTrig }
          else
            local matches = { string.match(docTrig, snippet.trigger) }
            for i, match in ipairs(matches) do
              local idx = i ~= #matches and i or 0
              snippet.insert_nodes[idx].static_text = { match }
            end
          end
        end)
      end
    end

    local cursor = ctx.get_cursor()
    cursor[1] = cursor[1] - 1

    local range = require("blink.cmp.lib.text_edits").get_from_item(item).range
    local clear_region = {
      from = { range.start.line, range.start.character },
      to = cursor,
    }

    local line = ctx.get_line()
    local line_to_cursor = line:sub(1, cursor[2])
    local range_text = line:sub(range.start.character + 1, cursor[2])
    local keep_prefixed_clear_region = range_text:sub(1, #trigger) == trigger

    local expand_params = snip:matches(line_to_cursor, {
      fallback_match = range_text ~= line_to_cursor and range_text,
    })

    if expand_params ~= nil and not keep_prefixed_clear_region then
      if expand_params.clear_region ~= nil then
        clear_region = expand_params.clear_region
      elseif expand_params.trigger ~= nil then
        clear_region = {
          from = { cursor[1], cursor[2] - #expand_params.trigger },
          to = cursor,
        }
      end
    end

    luasnip.snip_expand(snip, { expand_params = expand_params, clear_region = clear_region })
  end
end

return {
  {
    -- inspired by https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/blink-cmp.lua
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "moyiz/blink-emoji.nvim",
      {
        "mikavilpas/blink-ripgrep.nvim",
        version = "*", -- use the latest stable version
      },
    },
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    version = "*",
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
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = require("sixzen.icons").kind,
      },

      sources = {
        default = { "lsp", "path", "buffer", "ripgrep", "snippets", "emoji" },
        per_filetype = {
          sql = { "dadbod" },
          -- optionally inherit from the `default` sources
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {},
            max_items = 3,
            min_keyword_length = 3,
            score_offset = 3,
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          lsp = {
            name = "LSP",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            score_offset = 90,
            fallbacks = { "ripgrep", "buffer" },
          },
          snippets = {
            name = "snippets",
            enabled = true,
            module = "blink.cmp.sources.snippets",
            override = {
              execute = execute_luasnip_with_trigger_prefix(trigger_text),
            },
            min_keyword_length = 2,
            -- fallbacks = { "snippets" },
            score_offset = 100,
            max_items = 15,
            should_show_items = function()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
              return before_cursor:match(trigger_text .. "%w*$") ~= nil
            end,
            transform_items = function(_, items)
              local line = vim.api.nvim_get_current_line()
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local before_cursor = line:sub(1, col)
              local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
              if start_pos then
                for _, item in ipairs(items) do
                  item.cursor_column = col
                  item.textEdit = vim.tbl_deep_extend("force", item.textEdit or {}, {
                    newText = item.textEdit and item.textEdit.newText or item.insertText or item.label,
                    range = {
                      start = { line = vim.fn.line "." - 1, character = start_pos - 1 },
                      ["end"] = { line = vim.fn.line "." - 1, character = end_pos },
                    },
                  })
                end
              end
              return items
            end,
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
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
          cmdline = {
            enabled = true,
          },
        },
      },
      snippets = {
        preset = "luasnip",
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
