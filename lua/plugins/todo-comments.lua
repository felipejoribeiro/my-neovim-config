return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
		keywords = {
			BUG = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "#f06caa" },
			WARN = { icon = " ", color = "#ffb86c", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "#9192ff", alt = { "INFO" } },
		},
  }
}
