function _G.is_key_mapped_to_buffer(bufnr, mode, key_combination)
	local buf_map = vim.api.nvim_buf_get_keymap(bufnr, mode)
	for _, mapping in ipairs(buf_map) do
		if mapping.lhs == key_combination then
			return true
		end
	end
	return false
end
