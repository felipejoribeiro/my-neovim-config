require('core.lsp_identifiers')

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-jest',
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    -- test single test
    MAPKEY('n', '<Leader>tm', "<cmd>lua require('neotest').run.run()<cr>", { silent = true })
    MAPKEY(
      'n',
      '<Leader>tM',
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      { silent = true }
    )
    -- Test file
    MAPKEY(
      'n',
      '<Leader>tc',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tC',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      { silent = true }
    )
    -- test function
    MAPKEY(
      'n',
      '<Leader>tf',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tF',
      "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
      { silent = true }
    )

    --test full project
    MAPKEY(
      'n',
      '<Leader>tp',
      "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>",
      { silent = true }
    )
    MAPKEY(
      'n',
      '<Leader>tP',
      "<cmd>lua require('neotest').run.run(vim.fn.getcwd(), {strategy = 'dap'})<cr>",
      { silent = true }
    )
    -- summary
    MAPKEY('n', '<Leader>tt', "<cmd>lua require('neotest').summary.toggle()<cr>", { silent = true })
    MAPKEY(
      'n',
      '<Leader>tk',
      "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
      { silent = true }
    )
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace('neotest')
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
            diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    -- python arguments
    local py_args = { '--log-level', 'DEBUG', '--quiet' }
    if CHECK_DJANGO() then
      py_args = vim.list_extend(py_args, { '--reuse-db' })
    end

    require('neotest').setup({
      adapters = {
        require('neotest-python')({
          dap = {
            justMyCode = true,
            console = 'integratedTerminal',
          },
          args = py_args,
          runner = 'pytest',
        }),
        require('neotest-jest')({
          jestCommand = 'npx jest',
          cwd = function(path)
            -- Walk up from the test file to find the nearest jest.config
            local root = path
            while root ~= '/' do
              root = vim.fn.fnamemodify(root, ':h')
              if vim.fn.filereadable(root .. '/jest.config.ts') == 1
                or vim.fn.filereadable(root .. '/jest.config.js') == 1 then
                return root
              end
            end
            return vim.fn.getcwd()
          end,
        }),
        require('neotest-go')({
          dap = {
            justMyCode = true,
            console = 'integratedTerminal',
          },
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        }),
      },
    })
  end,
}
