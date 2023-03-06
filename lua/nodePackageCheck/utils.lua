local function get_property(json_string, property_name)
	local start_index = string.find(json_string, '"' .. property_name .. '":')
		+ string.len('"' .. property_name .. '":')
	local end_index = string.find(json_string, ",", start_index) - 1
	return string.sub(json_string, start_index, end_index)
end

local utils = {}

utils.getPackageLatestVersion = function(packageName)
	local url = "https://registry.npmjs.org/" .. packageName .. "/latest"
	local handle = io.popen("curl -s '" .. url .. "'")
	if handle then
		-- read all file
		local response = handle:read("*a")
		handle:close()
		-- check if the package exist
		if string.find(response, "Not Found") then
			return response
		else
			return get_property(response, "version")
		end
	end
end

return utils
