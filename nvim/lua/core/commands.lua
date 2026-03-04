local cmd = vim.cmd

cmd("command W w")
cmd("command Wa wa")
cmd("command WA wa")

cmd("command Q q")
cmd("command Qa qa")
cmd("command QA qa")

cmd("command Sr GrugFar")
cmd("command SR GrugFar")

cmd("command Logs put=execute('messages')")

-- taken from https://stackoverflow.com/a/7615129/12694438
function Mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

vim.api.nvim_create_user_command("Logs", function()
	local output = vim.api.nvim_exec2("messages", { output = true }).output
	local output_lines = Mysplit(output, "\n")

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.list_extend(output_lines, { "" }))
	vim.api.nvim_set_current_buf(buf)

	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_cursor(win, { #output_lines, 0 })
end, {})
