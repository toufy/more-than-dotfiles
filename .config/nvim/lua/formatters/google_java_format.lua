local M = {}
local utils = require("myutils")

M.format = function()
	return {
		exe = "google-java-format",
		args = {
			"--aosp",
			utils.file_utils.get_buffer_name(),
		},
		stdin = true,
	}
end

return M
