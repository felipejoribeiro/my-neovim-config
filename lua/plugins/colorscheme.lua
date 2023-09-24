require("core.utils")

return {
  'Mofiqul/dracula.nvim',
  priority = 1000,
  config = function()
    vim.cmd[[colorscheme dracula]]

    -- load highlights
    local baseHl = {
      CursorLine = {bg = "none"},
      Normal = {bg = "none"},
      NormalFloat = {bg = "none"},
      FloatBorder = {bg = "none"},
      FloatBackground = {bg = "none"},
      Visual = {bg = "#6C76D7"},
      SignColumn = {link = "LineNr"},
    }
    LOAD_HIGHLIGHTS(baseHl)

    -- diagnostics
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      severity_sort = true,
    })
    local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
}
