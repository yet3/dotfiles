function _G.safe_plug_load(plug_name, plug_config)
	local status, plug = pcall(require, plug_name)

	if not status then
		local d_info = debug.getinfo(1)
		local first_line = "Error while loading plugin: " .. plug_name
		local msg = first_line

		if type(plug_config) == "table" then
			msg = msg .. "\n\nPlugin info:\n"
			msg = msg .. " url: " .. plug_config[1]
			if plug_config.name then
				msg = msg .. "\n name: " .. plug_config["name"]
			end
			if plug_config.branch then
				msg = msg .. "\n branch: " .. plug_config["branch"]
			end
			if plug_config.tag then
				msg = msg .. "\n tag: " .. plug_config["tag"]
			end
			if plug_config.priority then
				msg = msg .. "\n priority: " .. plug_config["priority"]
			end

			if plug_config.dependencies then
				msg = msg .. "\n dependencies:"
				for key, value in pairs(plug_config.dependencies) do
					if type(value) == "string" then
						msg = msg .. "\n  - " .. value
					else
						msg = msg .. "\n  - " .. value[1]
					end
				end
			end

			if plug_config.keys then
				msg = msg .. "\n keys:"
				for key, value in pairs(plug_config.keys) do
					msg = msg .. "\n  - " .. value
				end
			end

			if plug_config.cmd then
				msg = msg .. "\n cmds:"
				for key, value in pairs(plug_config.cmd) do
					msg = msg .. "\n  - " .. value
				end
			end

			msg = msg .. "\n\nFiles:"
			msg = msg .. "\n " .. d_info.short_src .. ":" .. d_info.currentline .. "  "
		end

		print(first_line)
		vim.notify(msg, "error")
		error()
	end

	return plug
end
