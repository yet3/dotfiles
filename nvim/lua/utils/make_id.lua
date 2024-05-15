function _G.make_id(length)
  local id = ""
  local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  local charset_length = #charset
  math.randomseed(os.time())

  for i = 1, length do
    local random_index = math.random(1, charset_length)
    id = id .. string.sub(charset, random_index, random_index)
  end

  return id
end
