-- Colorscheme definition
-- Author: @felipejoribeiro

---------------------------------------------------------
--- Diagnostics configuration
---------------------------------------------------------
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


---------------------------------------------------------
--- Colors and highlights
---------------------------------------------------------
vim.cmd[[colorscheme dracula]]

local function load_highlights(highlights)
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

local baseHl = {
  Visual = {bg = "#6C76D7"},
  CursorLine = {bg = "none"},
  Normal = {bg = "none"},
  NormalFloat = {bg = "none"},
  FloatBorder = {bg = "none"},
  FloatBackground = {bg = "none"}
}

local plugginsHl = {
  CopilotSuggestion = {fg = "#CC88FF"},
  TranslatorBorder = {bg = "none", fg = "#ffffff"},
  DapBreakpoint = {fg = "#FFFFFF"},
  DapStopped = {fg = "#00FF00"},
  NvimTreeIndentMarker = {fg = "#818EFF"},
  DashboardHeader = {fg = "#00FF00"},
  DashboardCenter = {},
  DashboardShortCut = {},
  DashboardFooter = {},
  CompeDocumentation = {bg = "none"},
  CompeNormal = {bg = "none"},
  TelescopeNormal = {bg = "none", link = "Normal"},

  CmpItemAbbr = {fg = "#818EFF", bg = "none"},
  CmpItemAbbrMatch = {fg = "#00FF00", bold = true, bg = "none"},
  CmpItemKind = {fg = "#818EFF", bg = "none"},
  CmpItemMenu = {fg = "#818EFF", bg = "none"},
  CmpItemKindVariable = {fg = "#9CDCFE", bg = "none", bold = true},
  CmpItemKindInterface = {link = "CmpItemKindVariable"},
  CmpItemKindText = {link = "CmpItemKindVariable"},
  CmpItemKindFunction = {fg = "#C586C0", bold = true, bg = "none"},
  CmpItemKindMethod = {link = "CmpItemKindFunction"},
  CmpItemKindKeyword = {fg = "#D4D4D4", bg = "none", bold = true},
  CmpItemKindProperty = {link = "CmpItemKindKeyword"},
  CmpItemKindUnit = {link = "CmpItemKindKeyword"},
  CmpFloatBorderHL = {fg = "#FFFFFF", bg = "none"},
  CmpNormalHL = {bg = "none"},
}

load_highlights(baseHl)
load_highlights(plugginsHl)
