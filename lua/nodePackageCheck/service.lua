local Messages = require("nodePackageCheck.messages")
local Service = {}

-- Remove spaces from a string
local function trim_string(s)
	return s:gsub(" ", "")
end
-- End

-- Check the last version from package name calling registry.npmjs
Service.get_package_latest_version = function(packageName)
	-- Make a call to registry.npmjs to retrieve the package last version
	local url = "https://registry.npmjs.org/" .. trim_string(packageName) .. "/latest"
	local cmd = "curl -s '" .. url .. '\' | grep -Po \'(?<="version":")[^"]*\''
	local handle = io.popen(cmd)
	if handle then
		-- read all file
		local version = handle:read("*line")
		handle:close()
		-- check if the package exist
		if version == nil or version == "" or version:find("Not Found") then
			print(Messages.ERROR_MESSAGES.PACKAGE_NOT_FOUND)
			return nil
		else
			coroutine.yield(version)
		end
	end
end
-- End

-- async logic

return Service
