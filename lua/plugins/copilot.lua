return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_node_command = "~/.nvm/versions/node/v16.15.0/bin/node"
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.g.copilot_filetypes = {
      ["dap-repl"] = false,
      ["dapui_watches"] = false,
    }
  end
}
