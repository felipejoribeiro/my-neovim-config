return {
	"stevearc/oil.nvim",
	config = function()
		-- INFO: keymaps
		MAPKEY("n", "-", "<CMD>Oil<CR>", { silent = true })

		require("oil").setup({
			default_file_explorer = true,
			columns = {
				"icon",
				"mtime",
				"size",
			},
		})
	end,
}
