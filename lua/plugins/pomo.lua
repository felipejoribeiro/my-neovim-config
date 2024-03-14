return {
	"epwalsh/pomo.nvim",
	version = "*",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	config = function()
		-- INFO: keymaps
		MAPKEY("n", "<Leader>t", ":TimerStart 30m<CR>", { silent = true })
		MAPKEY("n", "<Leader>tt", ":TimerStart 15m<CR>", { silent = true })
		MAPKEY("n", "<Leader>tp", ":TimerPause<CR>", { silent = true })
		MAPKEY("n", "<Leader>tr", ":TimerResume<CR>", { silent = true })
		MAPKEY("n", "<Leader>ts", ":TimerStop<CR>", { silent = true })

		-- load highlights
		local baseHl = {
			NotifyBackground = { bg = "#000000" },
		}
		LOAD_HIGHLIGHTS(baseHl)

		require("pomo").setup({
			update_interval = 1000,
		})
	end,
}
