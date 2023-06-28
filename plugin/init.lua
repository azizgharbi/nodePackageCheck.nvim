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
-- Clear buffer
Clear_highlights = function()
	vim.api.nvim_buf_clear_namespace(0, require("nodePackageCheck").Config.get_namespace_id(), 0, -1)
end

-- Undo and clear the current buffer
vim.api.nvim_set_keymap("n", "u", ":undo<CR>:lua Clear_highlights()<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("NPCUpdateLineVersion", function()
	Clear_highlights()
	local _, error = pcall(require("nodePackageCheck").Utils.confirmation_to_update_line_version)
	if error then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, {})

vim.api.nvim_create_user_command("NPCUpdateMultipleLinesVersion", function()
	Clear_highlights()
	local _, sucess = pcall(require("nodePackageCheck").Utils.mutiple_update_lines_version)
	if not sucess then
		print(require("nodePackageCheck").Messages.ERROR_MESSAGES.SOMETHING_WRONG)
	end
end, { range = true })
-- End
