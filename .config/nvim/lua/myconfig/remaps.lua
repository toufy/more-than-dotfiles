-- space as leader
vim.g.mapleader = " "
-- explorer with ` cd`
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
-- split view
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)
