local M = {}
local utils = require("myutils")

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
			utils.file_utils.get_buffer_name(),
		},
		stdin = true,
	}
end

return M
