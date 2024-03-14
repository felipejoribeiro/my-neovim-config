return {
	"ixru/nvim-markdown",
	ft = { "markdown" },
	config = function()
		-- INFO: nvim conceal settings
		vim.g.vim_markdown_frontmatter = 1
		vim.g.vim_markdown_conceal = 2
		vim.g.vim_markdown_no_default_key_mappings = 1
	end,
}
