return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require('dbee').install()
  end,
  config = function()
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      desc = 'On buffer enter with file type sql',
      group = vim.api.nvim_create_augroup('dbee', { clear = true }),
      pattern = { 'sql' },
      callback = function()
        vim.keymap.set({ 'n' }, '<leader>de', function()
          local function get_query()
            local ts_utils = require('nvim-treesitter.ts_utils')
            local current_node = ts_utils.get_node_at_cursor()

            local last_statement = nil
            while current_node do
              if current_node:type() == 'statement' then
                last_statement = current_node
              end
              if current_node:type() == 'program' then
                break
              end
              current_node = current_node:parent()
            end

            if not last_statement then
              return ''
            end

            local srow, scol, erow, ecol = vim.treesitter.get_node_range(last_statement)
            local selection = vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
            return table.concat(selection, '\n')
          end

          local query = get_query()
          local command = string.format('Dbee execute %s', query)
          vim.api.nvim_command(command)
        end, { desc = '[D]bee [e]xecute query under cursor' })
      end,
    })

    require('dbee').setup({
      sources = {
        require('dbee.sources').MemorySource:new({
          {
            name = 'server-db',
            type = 'postgres',
            url = 'postgres://django:django@localhost:5432/server-db?sslmode=disable',
          },
        }),
      },
    })
  end,
}
