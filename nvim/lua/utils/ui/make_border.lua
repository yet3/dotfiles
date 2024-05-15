function _G.make_border(hi)
	if hi == nil then
		hi = "CmpBorder"
	end
	return {
		{ "╭", hi },
		{ "─", hi },
		{ "╮", hi },
		{ "│", hi },
		{ "╯", hi },
		{ "─", hi },
		{ "╰", hi },
		{ "│", hi },
	}
end
