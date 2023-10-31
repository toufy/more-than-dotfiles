local lint = require("lint")
local pylint = lint.linters.pylint

-- linters
lint.linters_by_ft = {
	python = { "pylint" },
	bash = { "shellcheck" },
}

-- linter configs
pylint.args = {
	"-f",
	"json",
	"--docstring-min-length=50",
}

-- lint autocmd
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
