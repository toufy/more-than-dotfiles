-- setup
require("mason").setup({})
local langs = require("langs")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers =
	{ "lua_ls", "pyright", "bashls", "clangd", "jdtls", "html", "cssls", "eslint", "jsonls" }

-- config
mason_lspconfig.setup({
	ensure_installed = servers,
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = lsp_capabilities,
			})
		end,
		-- lua
		lua_ls = langs.lua.handle_lua_ls,
		-- python
		pyright = langs.python.handle_pyright,
	},
})
