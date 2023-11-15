require("core.utils")
return {
	"preservim/vim-pencil",
	config = function()
		vim.g["pencil#autoformat"] = 0
		vim.g["pencil#conceallevel"] = 0

		-- INFO: keymaps
		MAPKEY("n", "<leader>p", "<cmd>PencilToggle<CR>", { silent = true })
	end,
}
