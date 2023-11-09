local M = {}

M.get_buffer_name = function()
	local fmutil = require("formatter.util")
	return fmutil.escape_path(fmutil.get_current_buffer_file_name())
end

return M
