local M = {}

M.format = function()
	return {
		exe = "isort",
		args = {
			"--profile",
			"black",
		},
	}
end

return M
