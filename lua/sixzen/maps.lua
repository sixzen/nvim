vim.keymap.set("n", "<Space>", "", {})
vim.g.mapleader = " "
vim.g.maplocalleader = "<C-/>"

-- Exit and save
-- vim.keymap.set("n", "<leader>q", ":q<Return>", { silent = true })
-- vim.keymap.set("n", "<leader>Q", ":q!<Return>", { silent = true })
-- vim.keymap.set("n", "<leader>w", ":w<Return>", { silent = true })

-- Movements
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Blazing fast replace a word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- format
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Do not yank with x
vim.keymap.set("n", "x", '"_x')

-- Increment/Decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Paste without yank.
vim.keymap.set("v", "<leader>p", '"_dP')

-- Indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Delete a word backwards
-- vim.keymap.set("n", "dw", 'vb"_d')

-- Select all
-- vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
vim.keymap.set("n", "<leader>te", ":tabedit<Return>", { silent = true })
-- Split window
vim.keymap.set("n", "<leader>ss", ":split<Return><C-w>w", { silent = true })
vim.keymap.set("n", "<leader>sv", ":vsplit<Return><C-w>w", { silent = true })
-- Move window
vim.keymap.set("n", "<leader><Tab>", "<C-w>w")
-- vim.keymap.set("", "s<left>", "<C-w>h")
-- vim.keymap.set("", "s<up>", "<C-w>k")
-- vim.keymap.set("", "s<down>", "<C-w>j")
-- vim.keymap.set("", "s<right>", "<C-w>l")
-- vim.keymap.set("", "sh", "<C-w>h")
-- vim.keymap.set("", "sk", "<C-w>k")
-- vim.keymap.set("", "sj", "<C-w>j")
-- vim.keymap.set("", "sl", "<C-w>l")

-- Resize window
vim.keymap.set("n", "<leader><left>", "5<C-w><")
vim.keymap.set("n", "<leader><right>", "5<C-w>>")
vim.keymap.set("n", "<leader><up>", "3<C-w>+")
vim.keymap.set("n", "<leader><down>", "3<C-w>-")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>x", ":lua require'sixzen.utils'.buf_kill('bd', 0, false) <CR>", { silent = true })
