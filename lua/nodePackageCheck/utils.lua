local utils = {}

--]]
-- Get current file name
--]]
utils.get_current_file_name = function()
	local file_name = vim.api.nvim_buf_get_name(0):match("^.+/(.+)$")
	return file_name
end
-- End
--]]

-- ]]
-- Function trim_string: this removes spaces from a string
--]]
utils.trim_string = function(s)
	return s:match("^%s*(.-)%s*$")
end
-- End
--]]

-- ]]
-- Function get_property: Get value from a property name
--]]
utils.get_property_value = function(json_string, property_name)
	local start_index = string.find(json_string, '"' .. property_name .. '":')
		+ string.len('"' .. property_name .. '":')
	local end_index = string.find(json_string, ",", start_index) - 1
	return string.sub(json_string, start_index, end_index):gsub('"', "")
end
-- End
--]]

--]]
-- Check the last version from package name calling registry.npmjs
--]]
utils.get_package_latest_version = function(packageName)
	if utils.trim_string(packageName) == nil then
		return "Package not Found"
	end
	--]
	-- Make a call to registry.npmjs to retrieve the package last version
	--]
	local url = "https://registry.npmjs.org/" .. utils.trim_string(packageName) .. "/latest"
	local handle = io.popen("curl -s '" .. url .. "'")
	if handle then
		-- read all file
		local response = handle:read("*a")
		handle:close()
		-- check if the package exist
		if response == nil or response == "" or string.find(response, "Not Found") then
			return "Package not Found"
		else
			return utils.get_property_value(response, "version")
		end
	end
	--]]
end
-- End
--]]

--]]
-- Is the current file package.json ?
--]]
utils.is_package_json_file = function()
	return utils.get_current_file_name() == "package.json"
end
-- End
--]]

--]]
-- Get version from the current line
--]]
utils.get_version_from_current_line = function()
	local current_line = vim.api.nvim_get_current_line()
	local version = current_line:match('"[%^]*([%d%.]+)"')
	return version
end
-- End
--]]

--]]
-- Get package name from the current line
--]]
utils.get_package_name_from_current_line = function()
	local current_line = vim.api.nvim_get_current_line()
	local package_name = current_line:match("^([^:]+)"):gsub('"', "")
	return package_name
end
-- End
--]]

--]]
-- Get new line version
--]]

utils.get_new_line_version = function()
	local current_line_version = utils.get_version_from_current_line() -- current line package version
	local current_line = vim.api.nvim_get_current_line() -- current line
	local current_line_package_name = utils.get_package_name_from_current_line() --current line package name
	local current_line_new_version = utils.get_package_latest_version(current_line_package_name) -- current updated version
	local current_line_with_new_version = string.gsub(current_line, current_line_version, current_line_new_version) -- current line with the new package version
	return current_line_with_new_version
end
--End
--]]

--]]
-- Confirmation to update line version
--]]
utils.confirmation_to_update_line_version = function()
	local packageName = utils.get_package_name_from_current_line()
	local new_version = utils.get_package_latest_version(packageName)
	local old_version = utils.get_version_from_current_line()
	if new_version ~= old_version then
		local q = vim.fn.input("DO you want to update this package version [Y/N]: ")
		if q == "y" or q == "Y" then
			utils.update_current_line_with_new_version()
		else
			return
		end
	else
		print("Info: You are using already the latest version")
	end
end
--End
--]]
--]]
--  Update the current line with new version
--]]
utils.update_current_line_with_new_version = function()
	local is_package_json = utils.is_package_json_file() -- is the current file package.json
	if is_package_json then
		local current_line_with_new_version = utils.get_new_line_version()
		-- Replace the line with the another with latest package version
		utils.set_text_in_current_line(current_line_with_new_version)
	else
		print("Error: please use this command in a package.json file")
	end
end
-- End
--]]

--]]
--  Set new text in the current line and save
--]]
utils.set_text_in_current_line = function(new_text)
	-- get the current line number
	local current_line_number = vim.fn.line(".")
	-- set the new text for the current line
	vim.api.nvim_buf_set_lines(0, current_line_number - 1, current_line_number, false, { new_text })
	-- save the changes
	vim.cmd("w")
end
-- End
--]]

return utils
