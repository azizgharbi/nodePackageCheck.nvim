-- ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
-- ██░▀██░██░▄▄▄░██░▄▄▀██░▄▄▄██░▄▄░█░▄▄▀██░▄▄▀██░█▀▄█░▄▄▀██░▄▄░██░▄▄▄██░▄▄▀██░██░██░▄▄▄██░▄▄▀██░█▀▄
-- ██░█░█░██░███░██░██░██░▄▄▄██░▀▀░█░▀▀░██░█████░▄▀██░▀▀░██░█▀▀██░▄▄▄██░█████░▄▄░██░▄▄▄██░█████░▄▀█
-- ██░██▄░██░▀▀▀░██░▀▀░██░▀▀▀██░████░██░██░▀▀▄██░██░█░██░██░▀▀▄██░▀▀▀██░▀▀▄██░██░██░▀▀▀██░▀▀▄██░██░
-- ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

local npc = require("nodePackageCheck")
local npc_config = require("nodePackageCheck.config")

-- Load highlight groups
npc_config.error_highlight()
npc_config.success_highlight()
npc_config.info_highlight()
npc_config.warning_highlight()
--End

-- Commands definition
vim.api.nvim_create_user_command("NodepackagecheckVersion", function(opts)
	if opts.args == nil then
		print(npc.config.ERROR_MESSAGES.MISSING_PACKAGE_NAME)
		return
	end
	print(npc.utils.get_package_latest_version(opts.args))
end, { nargs = 1 })

vim.api.nvim_create_user_command("NodepackagecheckUpdateLineVersion", function()
	npc.utils.confirmation_to_update_line_version()
end, {})
-- End
