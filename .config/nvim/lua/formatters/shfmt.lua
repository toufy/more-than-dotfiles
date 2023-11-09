local M = {}

M.format = function()
	return {
		exe = "shfmt",
		args = {
			"-i",
			"4",
		},
		stdin = true,
	}
end

return M
