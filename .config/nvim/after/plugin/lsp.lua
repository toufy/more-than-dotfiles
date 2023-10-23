local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
	-- default keybinds
	lsp_zero.default_keymaps({buffer = bufnr})
end
)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'lua_ls', 'pylsp', 'bashls', 'clangd'},
	handlers = {
		lsp_zero.default_setup,
		-- lua
		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				-- setup for neovim config #BEGIN
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if not vim.loop.fs_stat(path..'/.luarc.json')
						and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
						client.config.settings = vim.tbl_deep_extend(
						'force', client.config.settings, {
							Lua = {
								runtime = {
									version = 'LuaJIT'
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME
									}
								}
							}
						})
						client.notify("workspace/didChangeConfiguration",
						{ settings = client.config.settings })
					end
					return true
				end
				-- setup for neovim config #END 
			})
		end,
	},
})

