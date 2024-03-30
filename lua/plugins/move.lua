return {
  'matze/vim-move',
  config = function()
    local glo = vim.g
    glo.move_key_modifier = 'A'
    glo.move_key_modifier_visualmode = 'A'
  end,
}
