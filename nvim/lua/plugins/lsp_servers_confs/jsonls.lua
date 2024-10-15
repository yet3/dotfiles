return {
	setup = function()
		local schemas = require("schemastore")
		return {
			settings = {
				json = {
					schemas = schemas.json.schemas(),
					validate = { enable = true },
				},
			},
		}
	end,
}
