function _G.str_split(in_str, sep)
	if sep == nil then
		sep = "%s"
	end

	local t = {}
	for str in string.gmatch(in_str or "", "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end
