return {
  "L3MON4D3/LuaSnip", -- Snippets
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
    },
  },
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require "luasnip"

    local options = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }

    luasnip.config.set_config(options)
    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    require("luasnip").filetype_extend("javascript", { "html" })

    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
          require("luasnip").unlink_current()
        end
      end,
    })

    local ls = require "luasnip"

    -- Add prefix ";" to each one of my snippets using the extend_decorator
    -- I use this in combination with blink.cmp. This way I don't have to use
    -- the transform_items function in blink.cmp that removes the ";" at the
    -- beginning of each snippet. I added this because snippets that start with
    -- a symbol like ```bash aren't having their ";" removed
    -- https://github.com/L3MON4D3/LuaSnip/discussions/895
    -- NOTE: THis extend_decorator works great, but I also tried to add the ";"
    -- prefix to all of the snippets loaded from friendly-snippets, but I was
    -- unable to do so, so I still have to use the transform_items in blink.cmp
    local extend_decorator = require "luasnip.util.extend_decorator"
    -- Create trigger transformation function
    local function auto_semicolon(context)
      if type(context) == "string" then
        return { trig = ";" .. context }
      end
      return vim.tbl_extend("keep", { trig = ";" .. context.trig }, context)
    end
    -- Register and apply decorator properly
    extend_decorator.register(ls.s, {
      arg_indx = 1,
      extend = function(original)
        return auto_semicolon(original)
      end,
    })
    local s = extend_decorator.apply(ls.s, {})

    -- local keymap = vim.api.nvim_set_keymap
    -- local opts = { noremap = true, silent = true }
    -- keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    -- keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    -- keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    -- keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

    require "config.snippets"
  end,
}
