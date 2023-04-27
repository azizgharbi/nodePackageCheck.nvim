local Highlights = {}

-- highlight groups
Highlights.error_highlight = function()
	vim.api.nvim_command("highlight error_highlight guifg=#e74c3c guibg=#e74c3cad")
end

Highlights.success_highlight = function()
	vim.api.nvim_command("highlight success_highlight guifg=#27ae60 guibg=#27ae6075")
end

Highlights.info_highlight = function()
	vim.api.nvim_command("highlight info_highlight guifg=#3498db guibg=#3498db8a")
end

Highlights.warning_highlight = function()
	vim.api.nvim_command("highlight warning_highlight guifg=#f1c40f guibg=#f1c40f6b")
end
-- End

return Highlights
