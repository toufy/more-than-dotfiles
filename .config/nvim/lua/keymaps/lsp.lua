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
