return {
	"szw/vim-g",
	config = function()
		-- INFO: keymaps
		MAPKEY("v", "<leader>ss", ":Google<CR>")
		MAPKEY("n", "<leader>ss", ":Google<CR>")

		if GET_OS_NAME() ~= "Mac arm" then
			vim.g.vim_g_open_command = "qutebrowser"
		end

		vim.g.vim_g_python_command = "python3"
		vim.g.vim_g_query_url = "https://google.com/search?q="
	end,
}
