local M = {}

M.format = function()
	return {
		exe = "stylua",
		args = {
			"--column-width",
			"100",
		},
	}
end

return M
