-- relative line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
-- tab size of 4 spaces with smart indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
-- no line wrap
vim.opt.wrap = false
-- better search
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- better colors
vim.opt.termguicolors = true
-- scroll page with 6 line margins
vim.opt.scrolloff = 6
-- 50ms update time
vim.opt.updatetime = 50
-- highlight cursor
vim.opt.cursorline = true
-- fuck touchpads
vim.opt.mouse = nil
-- yank/paste to/from clipboard
vim.opt.clipboard = "unnamedplus"
-- completions
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- diagnostic signs
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "󰙎" })
-- diagnostics config
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})
-- decorate hover windows
vim.lsp.handlers["textDocument/hover"] =
	vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
