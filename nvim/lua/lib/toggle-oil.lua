local function toggle_oil(path)
	require("oil").toggle_float(path or nil, {
		-- preview = {},
	})
end

return toggle_oil
