-- ]]
-- Function trim_string: this removes spaces from a string
--]]
local function trim_string(s)
	return s:match("^%s*(.-)%s*$")
end
-- End
--]]

-- ]]
-- Function get_property: Get value from a property name
--]]
local function get_property(json_string, property_name)
	local start_index = string.find(json_string, '"' .. property_name .. '":')
		+ string.len('"' .. property_name .. '":')
	local end_index = string.find(json_string, ",", start_index) - 1
	return string.sub(json_string, start_index, end_index)
end
-- End
--]]

local utils = {}

--]]
-- Check the last version from package name calling registry.npmjs
--]]
utils.get_package_latest_version = function(packageName)
	if trim_string(packageName) == nil then
		return "Package not Found"
	end
	--]
	-- Make a call to registry.npmjs to retrieve the package last version
	--]
	local url = "https://registry.npmjs.org/" .. trim_string(packageName) .. "/latest"
	local handle = io.popen("curl -s '" .. url .. "'")
	if handle then
		-- read all file
		local response = handle:read("*a")
		handle:close()
		-- check if the package exist
		if response == nil or response == "" or string.find(response, "Not Found") then
			return "Package not Found"
		else
			return get_property(response, "version")
		end
	end
	--]]
end
-- End
--]]

return utils
