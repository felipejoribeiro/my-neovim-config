local dap = require('dap')

local adapter_path = vim.fn.stdpath('config') .. '/local_dap/expo-cdp-proxy/adapter.js'

-- Register the Expo DAP adapter (executable, speaks DAP over stdin/stdout)
dap.adapters.expo = {
  type = 'executable',
  command = 'node',
  args = { adapter_path },
}

-- Expo terminal state (global to survive re-sourcing)
_G._expo_term = _G._expo_term or {
  buf = nil,
  chan = nil,
  win = nil,
}
local expo_term = _G._expo_term

local function recover_expo_term()
  if expo_term.buf and vim.api.nvim_buf_is_valid(expo_term.buf) and expo_term.chan then
    return true
  end
  -- Try to find an existing expo terminal buffer
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:find('npx expo start') then
        local chan = vim.b[buf].terminal_job_id
        if chan then
          expo_term.buf = buf
          expo_term.chan = chan
          return true
        end
      end
    end
  end
  return false
end

local function is_expo_running()
  return recover_expo_term()
end

local function start_expo(args)
  if is_expo_running() then
    vim.notify('[expo] Already running. Use :ExpoStop first.', vim.log.levels.WARN)
    return
  end

  -- Create a split at the bottom with a new buffer for the terminal
  vim.cmd('botright 15new')
  expo_term.win = vim.api.nvim_get_current_win()

  local cmd = 'npx expo start -c ' .. (args or '--android')
  expo_term.chan = vim.fn.termopen(cmd, {
    on_exit = function()
      expo_term.buf = nil
      expo_term.chan = nil
      expo_term.win = nil
    end,
  })
  expo_term.buf = vim.api.nvim_get_current_buf()

  -- Go back to previous window
  vim.cmd('wincmd p')
end

local function stop_expo()
  if is_expo_running() then
    vim.fn.jobstop(expo_term.chan)
    if expo_term.buf and vim.api.nvim_buf_is_valid(expo_term.buf) then
      vim.api.nvim_buf_delete(expo_term.buf, { force = true })
    end
    expo_term.buf = nil
    expo_term.chan = nil
    expo_term.win = nil
  end
end

local function toggle_expo_term()
  if not is_expo_running() then
    vim.notify('[expo] Not running. Use :ExpoGoAndroid to start.', vim.log.levels.WARN)
    return
  end

  -- Check if the terminal is visible in any window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == expo_term.buf then
      -- Visible — hide it
      vim.api.nvim_win_close(win, false)
      expo_term.win = nil
      return
    end
  end

  -- Not visible — show it in a bottom split
  vim.cmd('botright 15split')
  vim.api.nvim_set_current_buf(expo_term.buf)
  expo_term.win = vim.api.nvim_get_current_win()
  vim.cmd('wincmd p')
end

local function send_expo_key(key)
  if is_expo_running() then
    vim.api.nvim_chan_send(expo_term.chan, key)
    return true
  end
  return false
end

vim.api.nvim_create_user_command('ExpoGoAndroid', function()
  start_expo('--android')
end, {})

vim.api.nvim_create_user_command('ExpoGoIos', function()
  start_expo('--ios')
end, {})

vim.api.nvim_create_user_command('ExpoStop', function()
  stop_expo()
end, {})

vim.api.nvim_create_user_command('ExpoTermToggle', function()
  toggle_expo_term()
end, {})

-- Listen for the reload request from the adapter
dap.listeners.after.event_output['expo-reload'] = function(_, body)
  if body and body.output and body.output:find('%[expo%-dap%-reload%]') then
    vim.schedule(function()
      if not send_expo_key('r') then
        vim.notify(
          '[expo-dap] No Expo terminal. Start with :ExpoGoAndroid first.',
          vim.log.levels.WARN
        )
      end
    end)
  end
end

-- Add Expo debug config to JS/TS filetypes (only in Expo projects)
local function is_expo_project()
  local cwd = vim.fn.getcwd()
  return vim.fn.filereadable(cwd .. '/app.json') == 1
    or vim.fn.filereadable(cwd .. '/app.config.js') == 1
    or vim.fn.filereadable(cwd .. '/app.config.ts') == 1
end

local function has_expo_config()
  local configs = dap.configurations.typescriptreact or {}
  for _, cfg in ipairs(configs) do
    if cfg.type == 'expo' then
      return true
    end
  end
  return false
end

local function ensure_expo_config()
  if has_expo_config() or not is_expo_project() then
    return
  end

  local expo_attach = {
    type = 'expo',
    request = 'launch',
    name = 'Debug Expo (Hermes)',
    metroPort = 8081,
    projectRoot = vim.fn.getcwd(),
    -- verbose = true, -- uncomment to show [expo-dap] logs in REPL
  }

  local expo_reload = {
    type = 'expo',
    request = 'launch',
    name = 'Debug Expo (Reload)',
    metroPort = 8081,
    projectRoot = vim.fn.getcwd(),
    reloadOnAttach = true,
    -- verbose = true, -- uncomment to show [expo-dap] logs in REPL
  }

  local js_langs = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
  for _, ft in ipairs(js_langs) do
    dap.configurations[ft] = dap.configurations[ft] or {}
    table.insert(dap.configurations[ft], expo_attach)
    table.insert(dap.configurations[ft], expo_reload)
  end
end

local expo_reload_config = {
  type = 'expo',
  request = 'launch',
  name = 'Debug Expo (Reload)',
  metroPort = 8081,
  projectRoot = vim.fn.getcwd(),
  reloadOnAttach = true,
  verbose = true,
}

MAPKEY('n', '<leader>ja', '<cmd>ExpoGoAndroid<CR>', { desc = 'Expo: Start Android' })
MAPKEY('n', '<leader>jt', '<cmd>ExpoTermToggle<CR>', { desc = 'Expo: Toggle terminal' })
vim.keymap.set('n', '<leader>jr', function()
  local d = require('dap')
  local session = d.session()

  local function reconnect()
    vim.defer_fn(function()
      d.run(expo_reload_config)
    end, 2000)
  end

  if session then
    d.terminate(nil, nil, function()
      vim.schedule(reconnect)
    end)
  else
    reconnect()
  end
end, { noremap = true, desc = 'Expo: Restart DAP session' })

-- Register configs eagerly and also on BufRead for late-loaded projects
ensure_expo_config()

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  callback = function()
    ensure_expo_config()
  end,
})
