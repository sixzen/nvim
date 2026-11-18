local osc52 = require "vim.ui.clipboard.osc52"

local function paste()
  return { vim.fn.split(vim.fn.getreg '"', "\n"), vim.fn.getregtype '"' }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy "+",
    ["*"] = osc52.copy "*",
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

local scratch = "z"

vim.keymap.set({ "n", "x" }, "<leader>p", function()
  local lines = osc52.paste "+"()
  if type(lines) ~= "table" then
    return
  end
  local regtype = "v"
  if #lines > 1 and lines[#lines] == "" then
    table.remove(lines)
    regtype = "V"
  end

  local saved = vim.fn.getreginfo(scratch)
  vim.fn.setreg(scratch, lines, regtype)
  local visual = vim.fn.mode():match "^[vV\22]" ~= nil
  local ok, err = pcall(vim.cmd.normal, { '"' .. scratch .. (visual and "P" or "p"), bang = true })
  vim.fn.setreg(scratch, saved)
  if not ok then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Paste client clipboard (OSC 52)" })
