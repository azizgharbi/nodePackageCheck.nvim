local npc = require("nodePackageCheck")

--]]
-- Commands definition
--]]
local add_user_commands = vim.api.nvim_create_user_command

add_user_commands("Nodepackagecheck", function(opts)
	if opts.args == nil then
		print("Error: please provide a package name")
		return
	end
	print(npc.utils.get_package_latest_version(opts.args))
end, { nargs = 1 })

add_user_commands("NodepackagecheckUpdateCurrentLineVersion", function()
	local is_package_json = npc.utils.is_package_json_file() -- is the current file package.json
	if is_package_json then
		local current_line_version = npc.utils.get_version_from_current_line() -- current line package version
		local current_line = vim.api.nvim_get_current_line() -- current line
		local current_line_package_name = npc.utils.get_package_name_from_current_line() --current line package name
		local current_line_new_version = npc.utils.get_package_latest_version(current_line_package_name) -- current updated version
		local current_line_with_new_version = string.gsub(current_line, current_line_version, current_line_new_version) -- current line with the new package version

		-- TODO: replace the line with the another with latest package version
		print(current_line_with_new_version)
	else
		print("Error: please use this command in a package.json file")
	end
end, {})

-- End
--]]
