return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local octo = require('octo')

    octo.setup({
      mappings_disable_default = false, -- submit review only works with this set as false
      ui = {
        use_signcolumn = true,
        use_signstatus = true,
      },
      mappings = {
        pull_request = {
          checkout_pr = { lhs = '<localleader>p', desc = 'checkout PR' },
          list_changed_files = { lhs = '<localleader>pf', desc = 'list PR changed files' },
          open_in_browser = { lhs = '<localleader>pb', desc = 'open PR in browser' },
          add_label = { lhs = '<localleader>pl', desc = 'add label' },
          remove_label = { lhs = '<localleader>pL', desc = 'remove label' },
          reload = { lhs = '<C-r>', desc = 'reload PR' },
          add_comment = { lhs = '<localleader>pc', desc = 'add comment' },
          delete_comment = { lhs = '<localleader>pC', desc = 'delete comment' },
          react_thumbs_up = { lhs = '<localleader>p1', desc = 'add/remove 👍 reaction' },
          react_thumbs_down = { lhs = '<localleader>p2', desc = 'add/remove 👎 reaction' },
          react_heart = { lhs = '<localleader>p3', desc = 'add/remove ❤️ reaction' },
          react_eyes = { lhs = '<localleader>p4', desc = 'add/remove 👀 reaction' },
          react_rocket = { lhs = '<localleader>p5', desc = 'add/remove 🚀 reaction' },
          react_hooray = { lhs = '<localleader>p6', desc = 'add/remove 🎉 reaction' },
          react_laugh = { lhs = '<localleader>p7', desc = 'add/remove 😄 reaction' },
          react_confused = { lhs = '<localleader>p8', desc = 'add/remove 😕 reaction' },
          review_start = { lhs = '<localleader>pr', desc = 'start a review for the current PR' },
          review_resume = { lhs = '<localleader>pR', desc = 'resume pending review on current PR' },
        },
        file_panel = {
          submit_review = { lhs = '<localleader>rs', desc = 'submit review' },
          discard_review = { lhs = '<localleader>rd', desc = 'discard review' },
          toggle_files = { lhs = '<localleader>rf', desc = 'hide/show changed files panel' },
          select_entry = { lhs = '<cr>', desc = 'show selected changed file diffs' },
          refresh_files = { lhs = 'R', desc = 'refresh changed files panel' },
          select_next_entry = { lhs = ']r', desc = 'move to next changed file' },
          select_prev_entry = { lhs = '[r', desc = 'move to previous changed file' },
          close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
          toggle_viewed = { lhs = '<localleader><space>', desc = 'toggle viewer viewed state' },
        },
        review_diff = {
          submit_review = { lhs = '<localleader>rs', desc = 'submit review' },
          discard_review = { lhs = '<localleader>rd', desc = 'discard review' },
          add_review_comment = { lhs = '<localleader>rc', desc = 'add a new review comment' },
          add_review_suggestion = { lhs = '<localleader>rs', desc = 'add a new review suggestion' },
          toggle_files = { lhs = '<localleader>rf', desc = 'hide/show changed files panel' },
          select_next_entry = { lhs = ']q', desc = 'move to next changed file' },
          select_prev_entry = { lhs = '[q', desc = 'move to previous changed file' },
          close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
          toggle_viewed = { lhs = '<localleader><space>', desc = 'toggle viewer viewed state' },
          goto_file = { lhs = 'gf', desc = 'go to file' },
        },
        review_thread = {
          add_comment = { lhs = '<localleader>rc', desc = 'add comment' },
          add_suggestion = { lhs = '<localleader>rs', desc = 'add suggestion' },
          delete_comment = { lhs = '<localleader>rd', desc = 'delete comment' },
          next_comment = { lhs = ']c', desc = 'go to next comment' },
          prev_comment = { lhs = '[c', desc = 'go to previous comment' },
          select_next_entry = { lhs = ']q', desc = 'move to next changed file' },
          select_prev_entry = { lhs = '[q', desc = 'move to previous changed file' },
          close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
          react_thumbs_up = { lhs = '<localleader>p1', desc = 'add/remove 👍 reaction' },
          react_thumbs_down = { lhs = '<localleader>p2', desc = 'add/remove 👎 reaction' },
          react_heart = { lhs = '<localleader>p3', desc = 'add/remove ❤️ reaction' },
          react_eyes = { lhs = '<localleader>p4', desc = 'add/remove 👀 reaction' },
          react_rocket = { lhs = '<localleader>p5', desc = 'add/remove 🚀 reaction' },
          react_hooray = { lhs = '<localleader>p6', desc = 'add/remove 🎉 reaction' },
          react_laugh = { lhs = '<localleader>p7', desc = 'add/remove 😄 reaction' },
          react_confused = { lhs = '<localleader>p8', desc = 'add/remove 😕 reaction' },
        },
      },
    })
    vim.treesitter.language.register('markdown', 'octo')

    MAPKEY('n', '<leader>fp', '<cmd>Octo pr list<CR>')
    MAPKEY('n', '<leader>po', '<cmd>Octo pr open<CR>')
  end,
}
