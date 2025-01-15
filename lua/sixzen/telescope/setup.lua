local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_layout = require "telescope.actions.layout"
-- local fb_actions = require("telescope").extensions.file_browser.actions

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    winblend = 0,
    path_display = { "smart" },
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
      -- preview_cutoff = 120,
      prompt_position = "top",
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.5)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    color_devicons = true,
    file_ignore_patterns = {
      "node_modules",
    },
    mappings = {
      n = {
        ["q"] = actions.close,
      },
      i = {
        -- ["<C-x>"] = false,
        -- ["<C-s>"] = actions.select_horizontal,
        ["<C-n>"] = "move_selection_next",
        ["<C-y>"] = set_prompt_to_entry_value,
        -- These are new :)
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
        -- ["<M-p>"] = action_layout.toggle_prompt_position,

        -- ["<M-m>"] = actions.master_stack,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- This is nicer when used with smart-history plugin.
        ["<C-k>"] = actions.cycle_history_next,
        ["<C-j>"] = actions.cycle_history_prev,
        -- ["<c-space>"] = function(prompt_bufnr)
        -- 	local opts = {
        -- 		callback = actions.toggle_selection,
        -- 		loop_callback = actions.send_selected_to_qflist,
        -- 	}
        -- 	require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
        -- end,

        -- ["<C-w>"] = function()
        -- 	vim.api.nvim_input("<c-s-w>")
        -- end,
      },
    },
    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- file_ignore_patterns = nil,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },

  pickers = {
    fd = {
      mappings = {
        n = {
          ["kj"] = "close",
        },
      },
    },
    git_branches = {
      mappings = {
        i = {
          ["<C-a>"] = false,
        },
      },
    },
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- borderchars = {
        --   prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        --   results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
        --   preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- },
        width = 0.8,
        previewer = false,
      },
    },
    frecency = {
      show_scores = true, -- Default: false
      -- If `true`, it shows confirmation dialog before any entries are removed from the DB
      -- If you want not to be bothered with such things and to remove stale results silently
      -- set db_safe_mode=false and auto_validate=true
      --
      -- This fixes an issue I had in which I couldn't close the floating
      -- window because I couldn't focus it
      db_safe_mode = false,       -- Default: true
      -- If `true`, it removes stale entries count over than db_validate_threshold
      auto_validate = true,       -- Default: true
      -- It will remove entries when stale ones exist more than this count
      db_validate_threshold = 10, -- Default: 10
      -- Show the path of the active filter before file paths.
      -- So if I'm in the `dotfiles-latest` directory it will show me that
      -- before the name of the file
      show_filter_column = false, -- Default: true
    },
    -- file_browser = {
    --   theme = "dropdown",
    --   -- disables netrw add use telescope-file-browser in its place
    --   hijack_netrw = true,
    --   sorting_strategy = "ascending",
    --   scroll_strategy = "cycle",
    --   mappings = {
    --     -- your custom inset mode mappings
    --     ["i"] = {
    --       ["<C-w>"] = function()
    --         vim.cmd "normal vbd"
    --       end,
    --     },
    --     ["n"] = {
    --       ["N"] = fb_actions.create,
    --       ["h"] = fb_actions.goto_parent_dir,
    --       ["/"] = function()
    --         vim.cmd "startinsert"
    --       end,
    --     },
    --   },
    -- },
  },
}

-- local normal_hl = vim.api.nvim_get_hl_by_name("Statusline", true)
-- local visual_hl = vim.api.nvim_get_hl_by_name("Visual", true)
-- local string_hl = vim.api.nvim_get_hl_by_name("String", true)
-- local error_hl = vim.api.nvim_get_hl_by_name("Error", true)
-- local statusline_hl = vim.api.nvim_get_hl_by_name("Statusline", true)
--
-- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = visual_hl.background, bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = normal_hl.background, bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = normal_hl.background, bg = string_hl.foreground })
-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = visual_hl.background, bg = visual_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = normal_hl.foreground, bg = visual_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = error_hl.foreground, bg = visual_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = normal_hl.background, bg = error_hl.foreground })
-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = normal_hl.background, bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = normal_hl.background })
-- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = normal_hl.background, bg = normal_hl.background })

-- require("telescope").load_extension "notify"
-- require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
require("telescope").load_extension "frecency"
-- require("telescope").load_extension "noice"
