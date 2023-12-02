local builtin = require("telescope.builtin")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- general
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>vs", vim.cmd.vsplit)
vim.keymap.set("n", "<leader>hs", vim.cmd.split)

-- undotree
vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)

-- telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		-- display hover information
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		-- go to definition
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		-- go to declaration
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		-- list references
		bufmap("n", "gl", "<cmd>lua vim.lsp.buf.references()<cr>")
		-- rename references
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<cr>")
		-- show diagnostics info
		bufmap("n", "gi", "<cmd>lua vim.diagnostic.open_float()<cr>")
	end,
})

-- harpoon
vim.keymap.set("n", "<leader>A", mark.add_file)
vim.keymap.set("n", "<leader>M", ui.toggle_quick_menu)
