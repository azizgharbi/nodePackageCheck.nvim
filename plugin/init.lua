local npc = require("nodePackageCheck")
local npc_config = require("nodePackageCheck.config")

--]]
-- Add highlight groups
npc_config.error_highlight()
--End
--]]

--]]
-- Commands definition
--]]
vim.api.nvim_create_user_command("Nodepackagecheck", function(opts)
	if opts.args == nil then
		print("Error: please provide a package name")
		return
	end
	print(npc.utils.get_package_latest_version(opts.args))
end, { nargs = 1 })

vim.api.nvim_create_user_command("NodepackagecheckUpdateCurrentLineVersion", function()
	npc.utils.confirmation_to_update_line_version()
end, {})
-- End
--]]

local groupCmd = vim.api.nvim_create_augroup("loadLatestVersion", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local buffer = vim.api.nvim_get_current_buf()
		local pattern = npc_config.package_version_pattern()
		local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

		for i, line in ipairs(lines) do
			if string.match(line, pattern) then
				-- TODO : work in progress
				npc_config.virtual_text_option(buffer, "Error", "error_highlight", i - 1, line:len())
			end
		end
	end,
	group = groupCmd,
})
