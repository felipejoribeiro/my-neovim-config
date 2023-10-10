require("core.utils")
return {
  "mbbill/undotree",
  config = function()
    -- INFO: keymaps
    MAPKEY("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
  end,
}
