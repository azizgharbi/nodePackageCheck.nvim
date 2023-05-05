-- ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
-- ██░▀██░██░▄▄▄░██░▄▄▀██░▄▄▄██░▄▄░█░▄▄▀██░▄▄▀██░█▀▄█░▄▄▀██░▄▄░██░▄▄▄██░▄▄▀██░██░██░▄▄▄██░▄▄▀██░█▀▄
-- ██░█░█░██░███░██░██░██░▄▄▄██░▀▀░█░▀▀░██░█████░▄▀██░▀▀░██░█▀▀██░▄▄▄██░█████░▄▄░██░▄▄▄██░█████░▄▀█
-- ██░██▄░██░▀▀▀░██░▀▀░██░▀▀▀██░████░██░██░▀▀▄██░██░█░██░██░▀▀▄██░▀▀▀██░▀▀▄██░██░██░▀▀▀██░▀▀▄██░██░
-- ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

-- Load highlight groups
require("nodePackageCheck").Highlights.error_highlight()
require("nodePackageCheck").Highlights.success_highlight()
require("nodePackageCheck").Highlights.info_highlight()
require("nodePackageCheck").Highlights.warning_highlight()
--End

-- Commands definition
vim.api.nvim_create_user_command("NodepackagecheckVersion", function(opts)
	if opts.args == nil then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.MISSING_PACKAGE_NAME)
		return
	end
	local s, res = pcall(require("nodePackageCheck").Utils.get_package_latest_version, opts.args)
	if s then
		print(res)
	else
		print(require("nodePackageCheck").Config.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, { nargs = 1 })

vim.api.nvim_create_user_command("NodepackagecheckUpdateLineVersion", function()
	local _, error = pcall(require("nodePackageCheck").Utils.confirmation_to_update_line_version)
	if error then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, {})

vim.api.nvim_create_user_command("TestPlugin", function()
	local selected_text, error = require("nodePackageCheck").Utils.show_selected_text()
	if error then
		print(error)
		return
	end
	print(selected_text)
end, { range = true })

-- End
