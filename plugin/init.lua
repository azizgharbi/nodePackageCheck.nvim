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
	npc.utils.update_current_line_with_new_version()
end, {})

-- End
--]]
