-- JS/TS debug adapter infrastructure (shared). Do NOT add `dap.configurations` here.
--
-- This file registers js-debug-adapter (installed via Mason) under the standard
-- adapter names (pwa-node, pwa-chrome, etc.). Framework-specific configurations
-- live in sibling files that APPEND to `dap.configurations[ft]`:
--   - nextjs.lua → Next.js launch configs, detected per project
--   - expo.lua   → Expo/React Native configs, own custom 'expo' adapter
--
-- To add support for a new framework: create adapters/<framework>.lua that
-- appends configs referencing these adapter names (type = 'pwa-node', etc.).
-- Do NOT assign `dap.configurations[ft] = {...}` — it overwrites other adapters'
-- appended configs. Always read-filter-reassign or append.

local dap = require('dap')

local js_debug_server = vim.fn.stdpath('data')
  .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'

for _, name in ipairs({
  'pwa-node',
  'pwa-chrome',
  'pwa-msedge',
  'node-terminal',
  'pwa-extensionHost',
  'node',
  'chrome',
}) do
  dap.adapters[name] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_server, '${port}' },
    },
  }
end
