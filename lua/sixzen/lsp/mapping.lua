vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Set diagnostic loclist" })
