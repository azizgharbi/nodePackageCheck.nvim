local Config = require("nodePackageCheck.config")
local Messages = require("nodePackageCheck.messages")

-- init
local Utils = {}

-- Get current file name
Utils.get_current_file_name = function()
	local file_name = vim.api.nvim_buf_get_name(0):match("^.+/(.+)$")
	return file_name
end
-- End

-- Remove spaces from a string
Utils.trim_string = function(s)
	return s:gsub(" ", "")
end
-- End

-- Check the last version from package name calling registry.npmjs
Utils.get_package_latest_version = function(packageName)
	if Utils.trim_string(packageName) == nil then
		print(Messages.ERROR_MESSAGES.PACKAGE_NOT_FOUND)
		return nil
	end
	-- Make a call to registry.npmjs to retrieve the package last version
	local url = "https://registry.npmjs.org/" .. Utils.trim_string(packageName) .. "/latest"
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
			return version
		end
	end
end
-- End

-- Is the current file package.json
Utils.is_package_json_file = function()
	return Utils.get_current_file_name() == "package.json"
end
-- End

-- Get version from the current line
Utils.get_version_from_current_line = function(line)
	local version = line:match('"[%^]*([%d%.]+)"')
	return version
end
-- End

-- Get package name from the current line
Utils.get_package_name_from_current_line = function(line)
	local package_name = line:match("^([^:]+)"):gsub('"', "")
	return package_name
end
-- End

--  Set new text in the current line and save
Utils.set_text_in_current_line = function(new_text, current_line_number)
	vim.api.nvim_buf_set_lines(0, current_line_number - 1, current_line_number, false, { new_text })
end
-- End

-- Get new line version
Utils.get_new_version_from_current_line = function()
	local current_line = vim.api.nvim_get_current_line() -- current line
	local current_line_version = Utils.get_version_from_current_line(current_line) -- current line package version
	local current_line_package_name = Utils.get_package_name_from_current_line(current_line) --current line package name
	local current_line_new_version = Utils.get_package_latest_version(current_line_package_name) -- current updated version
	if current_line_new_version then
		local current_line_with_new_version = current_line:gsub(current_line_version, current_line_new_version) -- current line with the new package version
		return current_line_with_new_version
	else
		return nil
	end
end
--End

-- Get old version and new version from the current line
Utils.get_package_line_info = function(line)
	local packageName = Utils.get_package_name_from_current_line(line)
	local new_version = Utils.get_package_latest_version(packageName)
	local old_version = Utils.get_version_from_current_line(line)
	return new_version, old_version
end
--End

-- Confirmation to update line version
Utils.confirmation_to_update_line_version = function()
	local current_line = vim.api.nvim_get_current_line() -- current line
	local new_version, old_version = Utils.get_package_line_info(current_line)
	local current_line_number = vim.fn.line(".") -- get the current line number

	if not current_line:match(Config.package_version_pattern()) then
		print(Messages.ERROR_MESSAGES.NO_PACKAGE)
		return
	end

	if new_version ~= old_version then
		local q = vim.fn.input(Messages.INFO_MESSAGES.QUESTION)
		if q == "y" or q == "Y" then
			Utils.update_current_line_with_new_version(current_line_number)
			Config.virtual_text_option(
				0,
				" " .. new_version,
				"success_highlight",
				current_line_number - 1,
				current_line:len()
			)
		else
			Config.virtual_text_option(
				0,
				" " .. new_version,
				"error_highlight",
				current_line_number - 1,
				current_line:len()
			)
		end
	else
		print(Messages.INFO_MESSAGES.GOOD_VERSION)
		Config.virtual_text_option(
			0,
			" " .. new_version,
			"success_highlight",
			current_line_number - 1,
			current_line:len()
		)
	end
end
--End

--  Update the current line with new version
Utils.update_current_line_with_new_version = function(current_line_number)
	local is_package_json = Utils.is_package_json_file() -- is the current file package.json
	if is_package_json then
		local current_line_with_new_version = Utils.get_new_version_from_current_line()
		-- Replace the line with the another with latest package version
		if current_line_with_new_version then
			Utils.set_text_in_current_line(current_line_with_new_version, current_line_number)
		end
	else
		print(Messages.ERROR_MESSAGES.WRONG_FILE)
	end
end
-- End

return Utils
