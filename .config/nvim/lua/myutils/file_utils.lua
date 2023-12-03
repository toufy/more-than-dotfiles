local M = {}

M.get_buffer_name = function()
	return vim.fn.expand("%:p")
end

return M
