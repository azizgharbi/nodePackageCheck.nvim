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
vim.api.nvim_create_user_command("NPCUpdateLineVersion", function()
	local _, error = pcall(require("nodePackageCheck").Utils.confirmation_to_update_line_version)
	if error then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, {})

vim.api.nvim_create_user_command("NPCUpdateMultipleLinesVersion", function()
	local _, error = pcall(require("nodePackageCheck").Utils.mutiple_update_lines_version)
	if error then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, { range = true })

-- End
