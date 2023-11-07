local M = {}

M.format = function()
	return {
		exe = "prettier",
		args = {
			"--print-width",
			"100",
			"--tab-width",
			"4",
			"--use-tabs",
			"--prose-wrap",
			"always",
			"--html-whitespace-sensitivity",
			"strict",
			"--single-attribute-per-line",
		},
	}
end

return M
