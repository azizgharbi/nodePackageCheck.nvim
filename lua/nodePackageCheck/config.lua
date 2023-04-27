local config = {}

-- patterns
config.package_version_pattern = function()
	return '"@?[%w-/_@]+":%s?"[~%^]?%d+%.%d+%.%d+"'
end
-- End

-- Clean namespace
config.get_namespace_id = function()
	return vim.api.nvim_create_namespace("nodePackageCheck")
end
-- End

-- Virtual text exception
config.virtual_text_option = function(buffer, virt_text, group_h, line_num, col_num)
	local namespace_id = config.get_namespace_id()
	local opts = {
		-- end_line = 10,
		virt_text = { { virt_text, group_h } },
		virt_text_pos = "overlay",
		-- virt_text_win_col = 20,
	}
	vim.api.nvim_buf_set_extmark(buffer, namespace_id, line_num, col_num, opts)
end
-- End

return config
