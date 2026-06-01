local dap = require('dap')

local exts = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }

local function find_upward(start, names)
  local path = start
  while path and path ~= '/' and path ~= '' do
    for _, name in ipairs(names) do
      local candidate = path .. '/' .. name
      if vim.fn.filereadable(candidate) == 1 then
        return candidate
      end
    end
    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      break
    end
    path = parent
  end
  return nil
end

local function has_next_dep(pkg_path)
  local ok, lines = pcall(vim.fn.readfile, pkg_path)
  if not ok then
    return false
  end
  local decoded_ok, data = pcall(vim.json.decode, table.concat(lines, '\n'))
  if not decoded_ok or type(data) ~= 'table' then
    return false
  end
  local deps = data.dependencies or {}
  local dev = data.devDependencies or {}
  return deps.next ~= nil or dev.next ~= nil
end

local function detect_nextjs_root(start)
  start = start or vim.fn.getcwd()

  local cfg = find_upward(start, {
    'next.config.js',
    'next.config.ts',
    'next.config.mjs',
    'next.config.cjs',
  })
  if cfg then
    return vim.fn.fnamemodify(cfg, ':h')
  end

  local pkg = find_upward(start, { 'package.json' })
  if pkg and has_next_dep(pkg) then
    return vim.fn.fnamemodify(pkg, ':h')
  end

  return nil
end

local function nextjs_configs(root)
  return {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Next.js: debug server-side',
      cwd = root,
      runtimeExecutable = 'npm',
      runtimeArgs = { 'run', 'dev' },
      console = 'integratedTerminal',
      autoAttachChildProcesses = true,
      skipFiles = { '<node_internals>/**' },
    },
    {
      type = 'pwa-chrome',
      request = 'launch',
      name = 'Next.js: debug client-side (launch Chrome)',
      url = 'http://localhost:3000',
      webRoot = root,
      sourceMaps = true,
      protocol = 'inspector',
      userDataDir = false,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      resolveSourceMapLocations = {
        root .. '/**',
        '!**/node_modules/**',
      },
    },
    {
      type = 'pwa-chrome',
      request = 'attach',
      name = 'Next.js: attach to Chrome (port 9222)',
      port = 9222,
      webRoot = root,
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
    },
  }
end

local function is_ours(conf)
  return conf.name and conf.name:match('^Next%.js: ') ~= nil
end

local function refresh()
  local root = detect_nextjs_root()

  for _, ext in ipairs(exts) do
    local existing = dap.configurations[ext] or {}
    local kept = {}
    for _, conf in ipairs(existing) do
      if not is_ours(conf) then
        table.insert(kept, conf)
      end
    end
    dap.configurations[ext] = kept

    if root then
      for _, conf in ipairs(nextjs_configs(root)) do
        table.insert(dap.configurations[ext], conf)
      end
    end
  end
end

refresh()

vim.api.nvim_create_autocmd('DirChanged', {
  group = vim.api.nvim_create_augroup('NextjsDapDetect', { clear = true }),
  callback = refresh,
})
