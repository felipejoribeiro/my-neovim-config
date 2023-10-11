return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = false,
		transparency = 50,
		floating_window = false,
		toggle_key = "<M-f>",
  },
  config = function(_, opts) require'lsp_signature'.setup(opts) end
}
