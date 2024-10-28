return {
  'rest-nvim/rest.nvim',
  config = function()
    function RunWithPreCommand()
      local pre = vim.fn.findfile('scripts/get-api-auth.sh', '.;')
      if pre ~= '' then
        vim.fn.system('bash ' .. pre)
      end

      vim.cmd('Rest run')
    end

    MAPKEY('n', '<leader>r', ':lua RunWithPreCommand()<CR>', { noremap = true, silent = true })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'json' },
      callback = function()
        vim.api.nvim_set_option_value('formatprg', 'jq', { scope = 'local' })
      end,
    })
    require('rest-nvim').setup({
      request = {
        skip_ssl_verification = true,
        hooks = {
          encode_url = true,
          user_agent = 'rest.nvim v' .. require('rest-nvim.api').VERSION,
          set_content_type = true,
        },
      },
      response = {
        hooks = {
          decode_url = true,
          format = true,
        },
      },
    })
  end,
}
