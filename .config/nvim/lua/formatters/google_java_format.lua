local M = {}
local util = require("formatter.util")

M.format = function()
	return {
		exe = "google-java-format",
		args = {
			"--aosp",
			util.escape_path(util.get_current_buffer_file_name()),
		},
		stdin = true,
	}
end

return M
