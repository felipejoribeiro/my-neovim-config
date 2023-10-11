return {
  'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = false },
      	code_actions = { show_server_name = true },
        definition = {
          keys = {
            edit = "o",
            tabe = "t",
          },
        },
      })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
}
