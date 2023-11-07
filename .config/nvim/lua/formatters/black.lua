local M = {}

M.format = function()
	return {
		exe = "black",
		args = {
			"--line-length",
			"100",
		},
	}
end

return M
