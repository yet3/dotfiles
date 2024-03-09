local cmd = vim.cmd
cmd("command W w")
cmd("command Wa wa")
cmd("command WA wa")

cmd("command Q q")
cmd("command Qa qa")
cmd("command QA qa")

local is_split_kbr_active = false
vim.api.nvim_create_user_command("SplitKbr", function()
  if is_split_kbr_active then
    is_split_kbr_active = false
  else
    is_split_kbr_active = true
  end
end, { nargs = 0 })
