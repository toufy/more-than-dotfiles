local M = {}

M.format = function()
	return {
		exe = "clang-format",
		args = {
			"--style=Microsoft",
			"--sort-includes",
		},
	}
end

return M
