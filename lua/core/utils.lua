-- function to show hidden characters
SHOW_HIDDEN = function()
	local show = vim.wo.list
	vim.wo.list = not show
	vim.opt.listchars = { space = ".", tab = ">~", eol = "¬", trail = "·" }
end

-- Functional wrapper for mapping custom keybindings
MAPKEY = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
MAPKEYBUF = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

-- highlight configuration shortcut
LOAD_HIGHLIGHTS = function(highlights)
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end
