local npc = require("nodePackageCheck")

--]]
-- Command definition
--]]
local add_user_commands = vim.api.nvim_create_user_command

add_user_commands("NodePackageCheck", function(args)
	if args == nil or #args == 0 then
		print("Error: Please provide a package name")
		return
	end
	local package_name = args[1]
	print(npc.utils.getPackageLatestVersion(package_name))
end, { nargs = 1 })
-- End
--]]
