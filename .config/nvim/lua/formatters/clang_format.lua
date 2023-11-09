local M = {}
local utils = require("myutils")

M.format = function()
	return {
		exe = "clang-format",
		args = {
			"--style=Microsoft",
			"--sort-includes",
			"--assume-filename",
			utils.file_utils.get_buffer_name(),
		},
		stdin = true,
	}
end

return M
