-- from: https://github.com/runiq/neovim-throttle-debounce/blob/main/lua/throttle-debounce/init.lua
---@param fn (function) Function to debounce
---@param timeout (number) Timeout in ms
---@param first (boolean, optional) Whether to use the arguments of the first
---call to `fn` within the timeframe. Default: Use arguments of the last call.
---@returns (function, timer) Debounced function and timer. Remember to call
----`timer:close()` at the end or you will leak memory!
function _G.debounce(fn, ms, first)
	local timer = vim.loop.new_timer()
	local wrapped_fn

	if not first then
		function wrapped_fn(...)
			local argv = { ... }
			local argc = select("#", ...)

			timer:start(ms, 0, function()
				pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
			end)
		end
	else
		local argv, argc
		function wrapped_fn(...)
			argv = argv or { ... }
			argc = argc or select("#", ...)

			timer:start(ms, 0, function()
				pcall(vim.schedule_wrap(fn), unpack(argv, 1, argc))
			end)
		end
	end
	return wrapped_fn, timer
end
