function _G.get_hi(hi_name)
  if vim.fn.hlexists(hi_name) ~= 1 then
    vim.notify("Couldn't get highlight \"" .. hi_name .. "\"\n\n" .. debug.traceback(), 'error', {
      title = "Missing highlight \"" .. hi_name .. "\""
    })
    return { bg = "#FF00FF", fg = "#FFFFFF" }
  end

  local data = vim.api.nvim_get_hl(0, { name = hi_name })
  local next = next

  local result = { bg = "NONE", fg = "NONE" }
  if next(data) ~= nil then
    if data['bg'] then
      result.bg = decimal_to_hex_color(data.bg)
    end
    if data['fg'] then
      result.fg = decimal_to_hex_color(data.fg)
    end
  end

  return result
end

function _G.get_hi_bg(hi_name)
  return get_hi(hi_name).bg
end

function _G.get_hi_fg(hi_name)
  return get_hi(hi_name).fg
end
