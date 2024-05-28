return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  event = {
    'BufReadPre ' .. vim.fn.expand('~') .. '/notes/**.md',
    'BufNewFile ' .. vim.fn.expand('~') .. '/notes/**.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  config = function()
    -- INFO: keymaps
    MAPKEY('n', '<leader>on', ':ObsidianNew<CR>', { silent = true })
    MAPKEY('n', '<leader>od', ':ObsidianDailies<CR>', { silent = true })
    MAPKEY('n', '<leader>op', ':ObsidianPasteImg<CR>', { silent = true })
    MAPKEY('n', '<leader>ot', ':ObsidianTags<CR>', { silent = true })
    MAPKEY('n', '<leader>os', ':ObsidianSearch<CR>', { silent = true })

    require('obsidian').setup({
      notes_subdir = 'fleeting',
      new_notes_location = 'notes_subdir',
      preferred_link_style = 'markdown',
      daily_notes = {
        folder = 'daily',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        template = 'daily',
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      image_name_func = function()
        local buffer_file_name = vim.fn.expand('%:t:r')
        local date = os.date('%Y-%m-%d-%H-%M-%S')
        return string.format('%s-%s-', buffer_file_name, date)
      end,
      note_id_func = function(title)
        local suffix = ''
        if title ~= nil then
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. '-' .. suffix
      end,
      attachments = {
        img_folder = 'assets/from_notes',
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          local datePattern = '%d%d%d%d%-%d%d%-%d%d%-%d%d%-%d%d%-%d%d%-'
          local _, endIndex = path.name:find(datePattern)

          local abbreviation
          if endIndex then
            abbreviation = path.name:sub(endIndex + 1)
          else
            abbreviation = path.name
          end

          return string.format('![%s](../%s)', abbreviation, path)
        end,
      },
      templates = {
        subdir = 'assets/templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        substitutions = {},
      },
      workspaces = {
        {
          name = 'Notes',
          path = '~/notes',
        },
      },
    })
  end,
}
