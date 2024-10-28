return {
  'diepm/vim-rest-console',
  event = { 'BufReadPre' },
  config = function()
    vim.g.vrc_set_default_mapping = 0
    vim.g.vrc_response_default_content_type = 'application/json'
    vim.g.vrc_output_buffer_name = 'response.json'
    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq',
    }

    function RunWithPreCommand()
      local pre = vim.fn.findfile('pre.sh', '.;')
      if pre ~= '' then
        vim.fn.system('bash ' .. pre)
      end
      vim.cmd('call VrcQuery()')
    end

    MAPKEY('n', '<leader>r', ':lua RunWithPreCommand()<CR>', { noremap = true, silent = true })
  end,
}
