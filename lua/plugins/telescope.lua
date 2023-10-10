require("core.utils")
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        layout_config = {
          width = 0.95,
          prompt_position = "bottom",
          preview_cutoff = 10,
        },
        color_devicons = true,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- add to quick fix list
            ["<space>x"] = require("telescope.actions").close, --quite
          },
          n = {
            ["<C-q>"] = require("telescope.actions").send_to_qflist,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Some color sdjustments
    local highlights = {
      TelescopeNormal = {bg = "none", link = "Normal"},
    }
    LOAD_HIGHLIGHTS(highlights)

    -- INFO: keymaps
    MAPKEY("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    MAPKEY("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>")
    MAPKEY("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    MAPKEY("n", "<leader>fG", "<cmd>Telescope grep_string<cr>")
    MAPKEY("n", "<leader>fb", "<cmd>lua require('telescope.builtin').git_branches()<CR>")
    MAPKEY("n", "<leader>ft", "<cmd>TodoTelescope <CR>")
  end,
}
