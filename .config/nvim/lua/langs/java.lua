local lspconfig = require("lspconfig")
local root_pattern = lspconfig.util.root_pattern
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local M = {}

-- lsp config
M.handle_jdtls = function()
	lspconfig.jdtls.setup({
		capabilities = lsp_capabilities,
		settings = {
			java = {
				project = {
					referencedLibraries = {
						"**/lib/*.jar",
					},
				},
				configuration = {
					runtimes = {
						{
							name = "JavaSE-17",
							path = "/usr/lib/jvm/java-17-openjdk",
						},
					},
				},
			},
		},
		root_dir = root_pattern(
			"mvnw",
			"build.xml",
			"pom.xml",
			".gradle",
			"gradlew",
			".git",
			vim.fn.getcwd()
		),
	})
end

return M
