local config = {}

config.package_version_pattern = function()
	return '"@*[%w-/_@]+": "%d+%.%d+%.%d+"'
end

config.get_namespace_id = function()
	return vim.api.nvim_create_namespace("nodePackageCheck")
end

config.error_highlight = function()
	vim.api.nvim_command("highlight error_highlight guifg=#15161e guibg=#e6324b")
end

config.success_highlight = function()
	vim.api.nvim_command("highlight success_highlight guifg=#15161e guibg=#e6324b")
end

config.info_highlight = function()
	vim.api.nvim_command("highlight info_highlight guifg=#15161e guibg=#e6324b")
end

config.warning_highlight = function()
	vim.api.nvim_command("highlight warning_highlight guifg=#15161e guibg=#e6324b")
end

return config
