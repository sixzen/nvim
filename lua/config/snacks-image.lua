local M = {}

M.CELL_WIDTH = 9
M.CELL_HEIGHT = 18

local function positive(n)
  return type(n) == "number" and n > 0
end

function M.fix_size(size)
  if type(size) ~= "table" or not positive(size.columns) or not positive(size.rows) then
    return size
  end
  local x_ok = positive(size.width) and positive(size.cell_width)
  local y_ok = positive(size.height) and positive(size.cell_height)
  if x_ok and y_ok then
    return size
  end
  local fixed = vim.tbl_extend("force", {}, size)
  if not x_ok then
    fixed.cell_width = M.CELL_WIDTH
    fixed.width = size.columns * M.CELL_WIDTH
  end
  if not y_ok then
    fixed.cell_height = M.CELL_HEIGHT
    fixed.height = size.rows * M.CELL_HEIGHT
  end
  return fixed
end

function M.prepare_env()
  local id = vim.env.HC_TERMINAL_ID
  if type(id) == "string" and id ~= "" and vim.env.SNACKS_SSH == nil then
    vim.env.SNACKS_SSH = "1"
  end
end

function M.install(terminal)
  M.prepare_env()
  terminal = terminal or require "snacks.image.terminal"
  if terminal._size_fallback_installed then
    return
  end
  local original = terminal.size
  terminal.size = function(...)
    return M.fix_size(original(...))
  end
  terminal._size_fallback_installed = true
end

return M
