function _G.has_plugin(plugin)
	return require("lazy.core.config").spec.plugins[plugin] ~= nil
end
