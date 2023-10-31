require("mason").setup({})
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- temporary solution to setup all servers, then customize select ones
local servers =
	{ "lua_ls", "pyright", "bashls", "clangd", "jdtls", "html", "cssls", "eslint", "jsonls" }
for _, lsvr in ipairs(servers) do
	require("lspconfig")[lsvr].setup({
		capabilities = capabilities,
	})
end

mason_lspconfig.setup({
	ensure_installed = servers,
	handlers = {
		-- lua
		lua_ls = function()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				-- setup for neovim config #BEGIN
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if
						not vim.loop.fs_stat(path .. "/.luarc.json")
						and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
					then
						client.config.settings =
							vim.tbl_deep_extend("force", client.config.settings, {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									workspace = {
										checkThirdParty = false,
										library = {
											vim.env.VIMRUNTIME,
										},
									},
								},
							})
						client.notify(
							"workspace/didChangeConfiguration",
							{ settings = client.config.settings }
						)
					end
					return true
				end,
				-- setup for neovim config #END
			})
		end,
		-- python
		pyright = function()
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "strict",
						},
					},
				},
			})
		end,
	},
})
