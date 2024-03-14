require("core.utils")
return {
	"preservim/vim-pencil",
	config = function()
		vim.g["pencil#autoformat"] = 2
		vim.g["pencil#conceallevel"] = 2

		-- INFO: keymaps
		MAPKEY("n", "<leader>P", ":Pencil<CR>", { silent = true })
	end,
}
