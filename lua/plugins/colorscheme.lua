require("core.utils")

return {
  'Mofiqul/dracula.nvim',
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme dracula]]

    -- load highlights
    local baseHl = {
      Visual = {bg = "#6C76D7"},
      CursorLine = {bg = "none"},
      Normal = {bg = "none"},
      NormalFloat = {bg = "none"},
      FloatBorder = {bg = "none"},
      FloatBackground = {bg = "none"}
    }
    LOAD_HIGHLIGHTS(baseHl)
  end
}
