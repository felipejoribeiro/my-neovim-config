require("core.utils")
return {
  "szw/vim-g",
  config = function()
    local os = GET_OS_NAME()

    -- INFO: keymaps
    MAPKEY("v", "<leader>ss", ":Google<CR>")
    MAPKEY("n", "<leader>ss", ":Google<CR>")

    if os ~= "Mac" then
      vim.g.vim_g_open_command = "xdg-open"
    end

    vim.g.vim_g_python_command = "python3"
    vim.g.vim_g_query_url = "https://duckduckgo.com/?q="
  end,
}
