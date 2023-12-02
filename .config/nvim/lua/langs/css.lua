local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local M = {}

-- lsp config
M.handle_cssls = function()
	lspconfig.cssls.setup({
		capabilities = lsp_capabilities,
		settings = {
			css = {
				validate = false,
			},
		},
	})
end

return M
