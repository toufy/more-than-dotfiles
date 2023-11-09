local M = {}
local utils = require("myutils")

M.format = function()
	return {
		exe = "stylua",
		args = {
			"--column-width",
			"100",
			"--stdin-filepath",
			utils.file_utils.get_buffer_name(),
			"--",
			"-",
		},
		stdin = true,
	}
end

return M
