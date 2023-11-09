local formatter = require("formatter")
local formatters = require("formatters")

formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { formatters.stylua.format },
		python = { formatters.isort.format, formatters.black.format },
		java = { formatters.google_java_format.format },
		c = { formatters.clang_format.format },
		cpp = { formatters.clang_format.format },
		html = { formatters.prettier.format },
		css = { formatters.prettier.format },
		javascript = { formatters.prettier.format },
		json = { formatters.prettier.format },
		sh = { formatters.shfmt.format },
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		vim.cmd("FormatWriteLock")
	end,
})
