local M = {}

local ft_to_lang = {
  typescriptreact = "tsx",
  javascriptreact = "jsx",
  typescript = "ts",
  javascript = "js",
}

local function copy(text, message)
  vim.fn.setreg("+", text)
  vim.notify(message, vim.log.levels.INFO)
end

-- Path relative to cwd, or the absolute (~-shortened) path when the file lives outside of it
local function display_path(abs)
  local root = vim.fn.getcwd()
  if abs:sub(1, #root + 1) == root .. "/" then
    return abs:sub(#root + 2)
  end
  return vim.fn.fnamemodify(abs, ":~")
end

local function buf_path()
  local abs = vim.api.nvim_buf_get_name(0)
  if abs == "" then
    vim.notify("Buffer has no file name", vim.log.levels.WARN)
    return nil
  end
  return abs
end

function M.yank_relative_path()
  local abs = buf_path()
  if not abs then
    return
  end
  local text = display_path(abs) .. "#L" .. vim.fn.line "."
  copy(text, "Copied " .. text)
end

function M.yank_absolute_path()
  local abs = buf_path()
  if not abs then
    return
  end
  local text = abs .. "#L" .. vim.fn.line "."
  copy(text, "Copied " .. text)
end

function M.copy_as_codeblock()
  local abs = buf_path()
  if not abs then
    return
  end
  local first, last = vim.fn.line "v", vim.fn.line "."
  if vim.fn.mode():match "^[vV\22]" == nil then
    first, last = vim.fn.line "'<", vim.fn.line "'>"
  end
  if first > last then
    first, last = last, first
  end
  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  local lang = ft_to_lang[vim.bo.filetype] or vim.bo.filetype

  local result = { "```" .. lang .. ' filename="' .. display_path(abs) .. '" line=' .. first }
  vim.list_extend(result, lines)
  table.insert(result, "```")
  vim.api.nvim_feedkeys(vim.keycode "<Esc>", "nx", false)
  copy(table.concat(result, "\n"), "Copied " .. #lines .. " lines as codeblock")
end

return M
