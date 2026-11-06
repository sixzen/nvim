vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

-- Cursorline only in the active window
local cursorline_group = vim.api.nvim_create_augroup("ActiveCursorline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = false
  end,
})
