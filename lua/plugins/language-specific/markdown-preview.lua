return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.cmd([[
      " use a custom Markdown style. Must be an absolute path
      " like '/Users/username/markdown.css' or expand('~/markdown.css')
      let g:mkdp_markdown_css = expand('~/.config/nvim/css/github_md_css.css')
      let g:mkdp_browser = '/usr/bin/qutebrowser'
    ]])
	end,
}
