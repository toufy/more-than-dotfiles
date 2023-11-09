local lint = require("lint")

-- linters
lint.linters_by_ft = {
	python = { "flake8" },
	bash = { "shellcheck" },
}

-- lint autocmd
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
