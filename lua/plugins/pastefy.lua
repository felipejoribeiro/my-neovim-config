return {
  'TobinPalmer/pastify.nvim',
  cmd = { 'Pastify', 'PastifyAfter' },
  config = function()
    require('pastify').setup({
      opts = {
        local_path = '/data/',
        save = 'local_file',
      },
    })
  end,
}
