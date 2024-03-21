return {
	"szw/vim-g",
	config = function()
		-- INFO: keymaps
		MAPKEY("v", "<leader>ss", ":Google<CR>")
		MAPKEY("n", "<leader>ss", ":Google<CR>")

		vim.g.vim_g_open_command = "qutebrowser"
		vim.g.vim_g_python_command = "python3"
		vim.g.vim_g_query_url = "https://google.com/search?q="
	end,
}
