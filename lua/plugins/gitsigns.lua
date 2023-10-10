require("core.utils")
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    MAPKEY("n", "<leader>gs", "<cmd>G<CR>")
    MAPKEY("n", "<leader>gb", "<cmd>Git blame<CR>")
    MAPKEY("n", "gD", "<cmd>Gitsigns diffthis<CR>")
  end,
}
