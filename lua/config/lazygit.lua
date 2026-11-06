-- Open files selected in lazygit (`e`) in the window lazygit was launched
-- from, instead of the new tab used by snacks' default "nvim-remote" preset.
-- Adapted from craftzdog/dotfiles (utils/lazygit.lua), using POSIX shell
-- syntax so it works with bash/zsh instead of fish.
local M = {}

---@type integer?
local origin_win = nil

--- Remember the current window as the edit target, then run a lazygit opener.
---@param fn? fun() defaults to `Snacks.lazygit()`
function M.open(fn)
  origin_win = vim.api.nvim_get_current_win()
  if fn then
    fn()
  else
    Snacks.lazygit()
  end
end

--- Focus the launch window so the following `nvim --remote` edits there.
--- No-op when that window was closed meanwhile.
function M.focus_origin()
  if origin_win and vim.api.nvim_win_is_valid(origin_win) then
    pcall(vim.api.nvim_set_current_win, origin_win)
  end
end

-- $NVIM is the RPC socket of the neovim instance hosting lazygit's terminal.
local nvim_server = 'nvim --server "$NVIM"'

--- Build a lazygit `os.edit` / `os.editAtLine` command. lazygit fills in
--- `{{filename}}` (already shell-quoted) and `{{line}}`.
---@param opts? { at_line?: boolean }
---@return string
function M.edit_command(opts)
  local at_line = opts and opts.at_line

  -- Launched outside neovim: edit directly.
  local outside = at_line and "nvim +{{line}} -- {{filename}}" or "nvim -- {{filename}}"

  -- Inside neovim: quit lazygit, refocus the launch window, open the file there.
  local inside = {
    nvim_server .. ' --remote-send "q"',
    nvim_server .. [[ --remote-send '<Cmd>lua require("config.lazygit").focus_origin()<CR>']],
    nvim_server .. " --remote {{filename}}",
  }
  if at_line then
    inside[#inside + 1] = nvim_server .. ' --remote-send ":{{line}}<CR>"'
  end

  return ('if [ -z "$NVIM" ]; then %s; else %s; fi'):format(outside, table.concat(inside, "; "))
end

return M
