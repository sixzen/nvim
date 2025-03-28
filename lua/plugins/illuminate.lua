return {
  "RRethy/vim-illuminate", -- Highlight all occurrences of the word under the cursor
  event = { "BufReadPre", "BufNewFile" },
  enabled = false,
  config = function()
    local illuminate = require "illuminate"

    illuminate.configure {
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      -- delay: delay in milliseconds
      delay = 120,
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
        "dashboard",
      },
      -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
      filetypes_allowlist = {},
      -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
      modes_denylist = {},
      -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
      modes_allowlist = {},
      -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_denylist = {},
      -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_allowlist = {},
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
    }

    vim.keymap.set(
      "n",
      "<C-n>",
      ':lua require("illuminate").goto_next_reference(true)<CR>',
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<C-p>",
      ':lua require("illuminate").goto_prev_reference(true)<CR>',
      { silent = true, noremap = true }
    )
  end,
}
