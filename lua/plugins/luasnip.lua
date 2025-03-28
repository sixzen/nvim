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

    -- local keymap = vim.api.nvim_set_keymap
    -- local opts = { noremap = true, silent = true }
    -- keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    -- keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
    -- keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    -- keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

    require "config.snippets"
  end,
}
