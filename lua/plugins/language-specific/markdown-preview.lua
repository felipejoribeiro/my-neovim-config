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
		vim.g.mkdp_theme = "dark"
		vim.g.mkdp_auto_start = 1
		vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/css/github_md_css.css")
		vim.g.mkdp_highlight_css = vim.fn.expand("~/.config/nvim/css/highlight.css")
		vim.g.mkdp_preview_options = {
			dark_mode = true,
		}

		-- check if vim is running in mac
		if GET_OS_NAME() == "Mac" then
			vim.g.mkdp_browser = "qutebrowser"
		else
			vim.g.mkdp_browser = "vimb"
		end
	end,
}
