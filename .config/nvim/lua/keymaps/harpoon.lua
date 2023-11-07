local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>A", mark.add_file)
vim.keymap.set("n", "<leader>M", ui.toggle_quick_menu)
