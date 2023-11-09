local M = {}
local utils = require("myutils")

M.format = function()
	return {
		exe = "black",
		args = {
			"-q",
			"--line-length",
			"100",
			"--stdin-filename",
			utils.file_utils.get_buffer_name(),
			"-",
		},
		stdin = true,
	}
end

return M
