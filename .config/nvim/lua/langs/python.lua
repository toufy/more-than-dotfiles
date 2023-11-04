-- setup
local lspconfig = require("lspconfig")
local path = require("lspconfig.util").path
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local M = {}

-- virtual envs
local function pyvenv(project_root)
	-- check available venv
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(project_root, pattern, "pyvenv.cfg"))
		if match ~= "" then
			local venv_dir = path.dirname(match)
			vim.env.VIRTUAL_ENV = venv_dir
			return path.join(venv_dir, "bin", "python")
		end
	end
	-- fallback to system python
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- lsp config
M.handle_pyright = function()
	lspconfig.pyright.setup({
		capabilities = lsp_capabilities,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true,
					typeCheckingMode = "strict",
				},
				pythonPath = pyvenv(vim.fn.trim(vim.fn.system("pwd"))),
			},
		},
	})
end

-- return table
return M
