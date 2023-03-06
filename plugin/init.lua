local npc = require("nodePackageCheck")

--]]
-- Command definition
--]]
local add_user_commands = vim.api.nvim_create_user_command

add_user_commands("NodePackageCheck", function(opts)
	if opts.args == nil then
		print("Error: Please provide a package name")
		return
	end
	print(npc.utils.getPackageLatestVersion(opts.args))
end, { nargs = 1 })
-- End
--]]
