return {
  'stevearc/oil.nvim',
  config = function()
    -- INFO: keymaps
    MAPKEY('n', '-', '<CMD>Oil<CR>', { silent = true })

    require('oil').setup({
      default_file_explorer = false,
      columns = {
        'icon',
        'mtime',
        'size',
      },
    })
  end,
}
