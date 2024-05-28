local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/.config/nvim/local_dap/vscode-node-debug2/src/nodeDebug.js' },
}

dap.configurations.typescriptreact = {
  {
    name = 'React native',
    type = 'node2',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    port = 35000,
  },
}
