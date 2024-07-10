require('core.utils')

-- global jobId variable
EMULATOR_JOB_ID = nil

OPEN_ANDROID_EMULATOR = function()
  -- use tmux to create a new window and run emulator -avd general
  vim.fn.system('tmux new-window -n emulator "source ~/.zshrc; emulator -avd general"')
end

CLOSE_ANDROID_EMULATOR = function()
  -- use tmux to kill the window
  vim.fn.system('tmux kill-window -t emulator')
end

MAPKEY('n', '<leader>js', '<cmd>lua OPEN_ANDROID_EMULATOR()<CR>')
MAPKEY('n', '<leader>jk', '<cmd>lua CLOSE_ANDROID_EMULATOR()<CR>')
