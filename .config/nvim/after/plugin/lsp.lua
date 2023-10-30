require("mason").setup({})
local mason_lspconfig = require("mason-lspconfig")
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(_, bufnr)
	-- default keybinds
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

mason_lspconfig.setup({
	ensure_installed = {
		-- lua
		"lua_ls",
		-- python
		"pyright",
		-- bash
		"bashls",
		-- c/c++
		"clangd",
	},
	handlers = {
		lsp_zero.default_setup,
		-- lua
		lua_ls = function()
			lspconfig.lua_ls.setup({
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
