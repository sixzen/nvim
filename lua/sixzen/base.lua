vim.cmd "autocmd!"

local shell = "zsh"

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.guifont = "Monolisa Simple Script,Symbols Nerd Font:h11"

vim.opt.completeopt = { "menuone", "noselect" }

vim.opt.shell = shell
if shell == "nu" then
  vim.opt.shellredir = "out+err> %s"
  vim.opt.shellcmdflag = "--stdin --no-newline -c"
  vim.opt.shelltemp = false
  vim.opt.shellxescape = ""
  vim.opt.shellxquote = ""
  vim.opt.shellquote = ""
  vim.opt.shellpipe =
    "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
end
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.hidden = true
vim.opt.pumheight = 10
vim.opt.breakindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.conceallevel = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 50
vim.opt.writebackup = false
vim.opt.signcolumn = "yes"
vim.opt.title = true
vim.opt.hlsearch = false
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 20
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.shiftwidth = 2
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.laststatus = 3 -- always show status line
vim.opt.ai = true -- Auto Indent
vim.opt.si = true -- Smart Indent
vim.opt.wrap = false -- No Wrap Lines
vim.opt.undofile = true
vim.opt.undodir = os.getenv "HOME" .. "/.cache/nvim/undodir"
vim.opt.backspace = "start,eol,indent"
vim.opt.path:append { "**" } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { "*/node_modules/*" }
vim.opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.list = true
vim.opt.listchars = "tab: ,trail:•"

vim.g.snippets = "luasnip"

if vim.fn.has "nvim-0.9.0" == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess = "filnxtToOFWIcC"
end

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]
-- doesn't work on iTerm2
--
vim.filetype.add {
  extension = {
    ["http"] = "http",
  },
}

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

vim.opt.formatoptions:append { "r" }

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    vim.cmd [[%s/\s\+$//e]]
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function(_)
    vim.cmd.setlocal "nonumber"
  end,
})

vim.g.markdown_recommended_style = 0
