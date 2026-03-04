local M = {}

---@param dir string
function M.scan_dir(dir)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen('ls "' .. dir .. '"')

	if pfile == nil then
		return {}
	end

	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end

	pfile:close()
	return t
end

return M
