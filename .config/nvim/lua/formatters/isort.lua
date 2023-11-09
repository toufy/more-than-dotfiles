local M = {}

M.format = function()
	return {
		exe = "isort",
		args = {
			"-q",
			"--profile",
			"black",
			"-",
		},
		stdin = true,
	}
end

return M
