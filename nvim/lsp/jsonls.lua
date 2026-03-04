local ok, schemas = pcall(require, "schemastore")

if not ok then
	return {}
end

return {
	settings = {
		json = {
			schemas = schemas.json.schemas(),
			validate = { enable = true },
		},
	},
}
