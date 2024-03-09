function _G.get_v_selected_text()
  if vim.api.nvim_get_mode().mode ~= "v" then
    return nil
  end

  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v') or ""
  vim.fn.setreg('v', {})

  if type(text) == 'table' then
    return ""
  end

  return string.gsub(text, "\n", "")
end
