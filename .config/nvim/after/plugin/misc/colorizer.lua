require("colorizer").setup({
	DEFAULT_OPTIONS = {
		RGB = false,
		RRGGBBAA = true,
		css_fn = true,
	},
	"*",
	-- exclude txt
	"!txt",
})

-- apply regardless of filetype
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		vim.cmd("ColorizerAttachToBuffer")
	end,
})
