local dap = require('dap')

dap.adapters.dart = {
  type = 'executable',
  command = 'dart',
  args = { 'debug_adapter' },
}

dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter',
  args = { 'debug_adapter' },
}

isLinux = function()
  return vim.loop.os_uname().sysname == 'Linux'
end

if isLinux() then
  dap.configurations.dart = {
    {
      type = 'flutter',
      request = 'launch',
      name = 'Launch flutter',
      dartSdkPath = '/opt/flutter/bin/cache/dart-sdk/bin/dart', -- ensure this is correct
      flutterSdkPath = '/opt/flutter/bin/flutter', -- ensure this is correct
      program = '${workspaceFolder}/lib/main.dart', -- ensure this is correct
      cwd = '${workspaceFolder}',
      repl_lang = 'dart',
    },
  }
else
  dap.configurations.dart = {
    {
      type = 'flutter',
      request = 'launch',
      name = 'Launch flutter',
      dartSdkPath = '/usr/lib/flutter/bin/cache/dart-sdk/bin/dart', -- ensure this is correct
      flutterSdkPath = '/usr/lib/flutter/bin/flutter', -- ensure this is correct
      program = '${workspaceFolder}/lib/main.dart', -- ensure this is correct
      cwd = '${workspaceFolder}',
      repl_lang = 'dart',
    },
  }
end
