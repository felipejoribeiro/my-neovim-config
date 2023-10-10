require("core.utils")
return {
  "voldikss/vim-translator",
  config = function()
    vim.g.translator_target_lang = "english"
    -- INFO: keymaps
    MAPKEY("n", "<Leader>w", "<cmd>TranslateW --engines=google --target_lang=pt<CR>", { silent = true })
    MAPKEY("n", "<Leader>W", "<cmd>TranslateW --engines=google --target_lang=en<CR>", { silent = true })
    MAPKEY("v", "<Leader>w", ":'<,'>TranslateW --engines=google --target_lang=pt<CR>", { silent = true })
    MAPKEY("v", "<Leader>W", ":'<,'>TranslateW --engines=google --target_lang=en<CR>", { silent = true })
  end
}
