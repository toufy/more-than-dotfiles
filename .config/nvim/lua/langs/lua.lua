local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local M = {}

-- lsp config
M.handle_lua_ls = function()
	lspconfig.lua_ls.setup({
		capabilities = lsp_capabilities,
		-- #BEGIN setup for neovim config BEGIN# --
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if
				not vim.loop.fs_stat(path .. "/.luarc.json")
				and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
			then
				client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
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
		-- #END setup for neovim config END# --
	})
end

return M
