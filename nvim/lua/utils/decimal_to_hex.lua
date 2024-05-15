function _G.decimal_to_hex(decimal)
	return string.format("%x", decimal)
end

function _G.decimal_to_hex_color(decimal)
	return "#" .. string.format("%x", decimal)
end
