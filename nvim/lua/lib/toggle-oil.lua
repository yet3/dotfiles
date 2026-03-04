local function toggle_oil(path)
	require("oil").toggle_float(path or nil, {
		-- preview = {},
	}, function()
		-- local function find_preview_window()
		-- 	for _, win in ipairs(vim.api.nvim_list_wins()) do
		-- 		local ok, val = pcall(vim.api.nvim_get_option_value, "previewwindow", { scope = "local", win = win })
		-- 		if ok and val then
		-- 			return win
		-- 		end
		-- 	end
		-- 	return nil
		-- end
		--
		-- local preview_win = find_preview_window()
		-- if preview_win then
		-- 	local current_config = vim.api.nvim_win_get_config(preview_win)
		--
		-- 	local w = current_config.width - 2
		-- 	vim.api.nvim_win_set_config(preview_win, {
		-- 		width = w,
		-- 		col = vim.o.columns - w,
		-- 		row = 0,
		-- 		relative = "editor",
		-- 	})
		-- end
	end)
end

return toggle_oil
