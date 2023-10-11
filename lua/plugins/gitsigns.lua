require("core.utils")
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local git_signs = require("gitsigns")
    git_signs.setup()

    -- INFO: Keybindings
    MAPKEY("n", "<leader>gs", "<cmd>G<CR>")
    MAPKEY("n", "<leader>gb", "<cmd>Git blame<CR>")
  end,
}
