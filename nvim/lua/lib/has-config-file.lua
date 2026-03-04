---@param files table<string>
---@return boolean
local function has_config_file(files)
	local root = vim.fs.root(vim.fn.expand("%:p"), files)

	if not root then
		return false
	end

	for _, file in ipairs(files) do
		if vim.fn.filereadable(root .. "/" .. file) == 1 then
			return true
		end
	end
	return false
end

return has_config_file
