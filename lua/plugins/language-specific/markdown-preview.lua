return {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		-- INFO: keymaps
		MAPKEY("n", "<Leader>j", ":MarkdownPreview<CR>", { silent = true })

		vim.g.mkdp_browser_dark = 1

		-- check if vim is running in mac
		if GET_OS_NAME() == "Mac" then
			vim.g.mkdp_browser = "qutebrowser"
		else
			vim.g.mkdp_browser = "vimb"
		end
	end,
}
