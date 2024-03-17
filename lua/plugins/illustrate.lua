return {
	"felipejoribeiro/illustrate.nvim",
	dir = "~/work/personal/illustrate.nvim",
	dependencies = {
		"rcarriga/nvim-notify",
	},
	keys = function()
		local illustrate = require("illustrate")
		return {
			{
				"<leader>is",
				function()
					illustrate.create_and_open_svg()
				end,
				desc = "Create and open a new SVG file with provided name.",
			},
			{
				"<leader>io",
				function()
					illustrate.open_under_cursor()
				end,
				desc = "Open file under cursor (or file within environment under cursor).",
			},
		}
	end,
	opts = {
		illustration_dir = "../assets/from_notes",
		relative_path = true,
		template_files = {
			directory = {
				svg = "~/notes/assets/templates/",
			},
			default = {
				svg = "default.svg",
			},
		},
		text_templates = {
			svt = {
				md = "![%s](../s%)",
			},
		},
	},
}
