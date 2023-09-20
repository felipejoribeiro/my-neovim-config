-- pluggins configuration
-- Author: @felipejoribeiro

local glo = vim.g
local fn = vim.fn
local home = os.getenv("HOME")
local os, _ = require("utils").get_os_name()

----------------------------------------------------
-- plugins configuration
----------------------------------------------------
local dashboardSetup = function()
	local setup, db = pcall(require, "dashboard")
	if not setup then
		return
	end

	db.session_directory = fn.stdpath("data") .. "/session"
	db.preview_command = "cat | lolcat -F 0.3"
	db.preview_file_path = home .. "/.config/nvim/octopus.txt"
	db.preview_file_height = 25
	db.preview_file_width = 60
	db.custom_center = {
		{
			icon = "  ",
			desc = "Find  File                              ",
			action = "Telescope find_files find_command=rg,--hidden,--files",
			shortcut = "SPC f f",
		},
		{
			icon = "  ",
			desc = "Find  word                              ",
			action = "Telescope live_grep",
			shortcut = "SPC f g",
		},
		{
			icon = "  ",
			desc = "Find  branch                            ",
			action = "Telescope git_branches",
			shortcut = "SPC f b",
		},
	}
	db.custom_footer = { " マインドキラー " }

	-- db.custom_header = {
	--   [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⢀⠀⠈⠻⢿⣿⣿⢿⣿⣿⢿⣿⢻⣆⠀⢻⣿⣿⣯⣼⣿⣯⣿⣷⡀⠘⡿⢿⣿⣿⣧⠀⠹⣿⣿⣿⣿⣿⡿⠟⠋⠀⣠⣿⣿⣿⣿⣿]],
	--   [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠑⢦⣀⠀⠉⠻⢾⣿⣿⣿⣿⣿⣿⡀⠀⢻⣟⣿⣿⣻⣿⣿⣿⣧⠀⠹⣿⣿⣿⡟⠀⣸⣿⣿⣿⡿⠋⠀⣠⣴⣿⠿⢿⢿⣿⣿⣿]],
	--   [[⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣧⣄⠈⠙⢷⣤⡀⠀⠙⢷⣿⣿⣿⣶⠧⡀⠈⢻⣿⣿⣿⣿⣿⣿⣿⠆⠀⢿⣿⠟⠀⣰⣿⣿⣿⡟⠁⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
	--   [[⣿⣿⣷⣿⡿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣶⡀⠀⠹⣿⣦⠀⠈⣿⣯⣽⣿⡟⣇⠀⠀⣿⣿⣿⣿⣿⡿⠟⠀⣠⠟⠁⢀⣼⣿⡿⠟⠁⢀⣴⣿⣿⣿⣿⣟⣿⣿⣿⣿⣯⠿]],
	--   [[⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠛⠋⠀⠀⣿⡋⠀⢰⡿⣿⣿⣿⣿⣿⠀⠀⣿⣿⣿⡿⠋⠀⢀⠔⠁⣀⣴⣿⣿⠋⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠉⢀⣠]],
	--   [[⠀⣠⣤⣤⣤⣤⣤⣤⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠉⠀⠀⣿⣿⣿⢿⢻⣿⡟⠀⠀⣯⣽⡽⠁⠀⢠⠁⣀⣬⣿⣯⡟⠁⠀⣴⣿⣿⣿⣽⣿⣾⣿⣿⡿⠟⠁⢀⣴⣿⣿]],
	--   [[⣾⣿⣿⣿⣿⣷⣿⡻⢿⣿⣿⠿⠛⠉⢀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣾⡿⠿⠃⠀⠀⡿⣿⠁⠀⠀⡎⣸⣿⣿⠿⠃⠀⣠⣾⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⣠⣾⣿⣿⣿⣿]],
	--   [[⣿⣿⣿⣿⣿⡿⣿⣷⡿⠛⢁⣠⣶⣿⣯⣿⣿⣶⣷⣄⠀⠀⠀⠙⠓⠙⠉⠀⠀⠀⠑⠚⠀⠀⠀⠀⠉⠋⠁⠀⢀⣴⣿⣿⣿⣿⣿⠟⠋⠀⢀⣀⣴⣾⣿⣿⣿⡟⠿⠿]],
	--   [[⣿⣿⣿⣿⡿⣿⣿⠟⢁⣴⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣷⡆⠀⠀⠀⢀⣠⣤⣶⣶⣶⣶⣤⣄⡀⠀⠀⠀⠠⣈⣿⣿⣿⣛⣿⠟⠁⠀⣠⠾⣿⣿⠿⠛⠉⠀⠀⠀⠀⠀]],
	--   [[⠀⠀⠉⠉⠙⠉⠋⠀⠺⣿⣿⣛⣿⣿⣿⣿⣟⣿⣿⣿⣽⣿⡷⣶⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⢴⣿⣿⠟⠛⠉⠀⠀⣠⡾⢿⠿⠋⠁⠀⠀⠀⠀⢀⣀⣀⡀]],
	--   [[⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣿⣿⣿⣏⣿⣿⡟⣿⣿⣿⣿⡟⠉⣛⢿⣿⣿⣿⡿⠿⣿⣿⡇⠁⠒⠀⠠⠄⠒⢀⣡⠾⠿⠋⠀⠀⠀⢀⣠⣤⣾⣿⣿⣿⣿⣿]],
	--   [[⣿⣿⣾⣿⣶⣶⣤⡀⠀⠀⠀⠀⠈⠚⢿⡷⡿⡿⠿⠤⠏⠋⠁⠀⢻⣧⣀⣈⣾⣿⣿⣿⠀⠂⢨⣿⠇⠀⠀⠀⠀⠒⠈⠉⠈⠀⠀⠀⠀⠀⠖⠛⠛⠉⠉⣉⡉⠉⠉⢉]],
	--   [[⣿⣿⣿⣿⣿⣿⣧⣍⣇⣄⠀⠀⠀⠀⠀⣀⣀⣀⣠⣴⠖⠒⠀⠀⠀⠉⡛⠿⠿⣿⣿⣿⡷⠶⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣴⣶⣻⣿⣿⣿⣿⣿⣿]],
	--   [[⠿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣷⣄⡀⠀⠸⠿⡿⠿⠟⠋⠀⠀⠀⠀⠴⠚⠁⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿]],
	--   [[⣤⣄⣀⡈⠉⠉⠉⠉⠉⠁⠛⠛⠛⠛⠲⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠄⠀⢀⠀⠳⠀⠀⠀⠀⠀⢀⣀⠀⣀⡠⢤⣾⣾⣿⣿⡿⠿⠓⠛⠿⢿⣽⣿⣿⣽⣿]],
	--   [[⣿⣻⣿⣿⣿⣯⣿⣿⣿⠷⣶⣤⣄⣀⠀⠀⠀⠀⠀⢀⣤⡀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠓⠚⠛⠉⠉⠁⠀⢀⣀⢀⣀⡀⠀⠉⠉⠉⠉]],
	--   [[⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡶⠟⠁⠀⠀⠀⢀⣴⣿⡶⠟⠁⠀⠀⣰⣶⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⡤⣤⣶⣾⣏⣿⣿⣿⣿⣾⣷⣶⣦⣤]],
	--   [[⠀⠘⠿⢿⣿⣿⢿⡽⠟⠊⠉⠀⠀⠀⠀⣀⣼⣿⣿⣽⣿⠦⠀⠀⣴⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠙⠻⣿⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣷⣿⣿]],
	--   [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⣿⣿⣿⣿⣿⣟⠂⠀⢸⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⣒⣄⠀⠀⠙⢾⡦⠀⠀⠀⠀⠀⠉⠙⠛⠛⠛⠿⠿⠿⢿⣿⣿⣿⣿]],
	--   [[⣶⣤⣀⣀⣀⣀⣀⣀⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⡿⠂⠀⢠⡿⠁⠀⠀⠀⠀⢠⣶⣦⡀⠀⠀⠙⣿⣧⠀⠀⠈⠿⣾⣷⣤⣀⡀⠀⠀⠀⠈⠉⠉⠛⠚⠲⠶⢭⡛⢿]],
	--   [[⠻⢿⣿⣿⣻⣿⣿⡿⣿⣿⣿⣿⣿⣿⣻⣿⢿⡿⠟⠁⠀⠀⠜⠁⢀⣦⠀⠀⠀⠸⣯⣿⣆⠀⠀⠀⠸⣿⣷⣤⡀⠀⠀⠀⠀⠈⠙⠿⣿⣿⣶⣶⣶⣶⣤⣄⡀⠀⠈⠓]],
	--   [[⠀⠀⠀⠉⠉⠙⠛⠛⠛⠛⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⢰⣿⣻⡄⠀⠀⠀⣿⣿⣿⣇⠀⠀⠀⠹⣿⣿⣿⣦⡀⠑⠶⣶⣄⣀⣀⣀⠉⠙⠛⠿⢿⣿⣿⣶⣄⡀]],
	--   [[⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣠⣿⣿⣛⣧⡀⠀⠀⠸⣏⣿⣿⣷⡀⠀⠀⠹⣿⣿⣿⣾⣶⣤⣀⠉⠉⠙⠛⠿⢷⣦⣤⣄⣀⣀⠉⠉⠉]],
	--   [[⣿⠀⢸⣿⣿⣿⣶⣶⣶⣶⢶⣶⠶⠶⠆⠀⣠⣄⠀⠻⣿⣿⣿⣿⣿⣿⣿⣓⡄⠀⠀⠹⣿⣿⣿⣷⡀⠀⠀⠹⣿⣿⣿⠿⣿⣿⣷⣶⠦⣄⡀⠀⠙⢿⣯⡽⠟⠋⠀⢀]],
	--   [[⣿⡀⠸⣿⣿⣿⣿⡿⢿⡿⠋⠀⣀⣤⠴⣾⣿⣿⣷⣄⠉⠻⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠹⣿⣹⣯⣹⠀⠀⠀⠈⠻⣿⣿⣿⣭⣿⣿⣿⡷⣽⣦⣀⠀⠀⠀⠀⠀⢀⣻]],
	--   [[⠻⣷⡀⠹⣿⣿⡿⣿⣿⠁⢠⣾⣷⣻⣿⣿⣿⣿⣿⣿⣷⡄⠈⢿⣿⣷⣾⣧⣿⣷⠀⠀⢀⣿⣿⣿⣿⣟⣰⣄⠀⠀⠈⠻⣿⢿⣿⣹⣿⣷⠿⠛⠁⠀⣀⣵⣴⣾⣿⣿]],
	--   [[⣀⡘⠧⠀⢼⣿⣟⣿⡇⠀⣞⣿⣿⣿⣿⣻⣿⣿⣷⣿⣿⣿⡄⠀⢻⣟⣿⣿⣿⠟⠀⠀⠀⠛⢿⣿⣿⣿⣿⣿⣳⣄⡀⠀⠀⠉⠉⠉⠉⣀⡠⠤⣒⣋⡁⠈⠛⢿⣿⣿]],
	--   [[⣿⣽⣷⣄⠈⢿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⡇⠀⣸⣿⣿⠟⠁⢀⣴⣾⣁⡄⠀⢿⣾⣿⣿⣿⣯⣿⣿⣆⡄⠀⢀⣤⣤⣶⣾⣿⢻⣿⣿⣦⣄⣀⢀⠀]],
	--   [[⣿⣿⣿⣿⣶⣄⡙⠻⣧⠈⢿⣿⣿⣿⣷⣾⣛⣿⣿⣿⣯⣿⠀⢀⣿⡛⠃⢀⣾⣏⣿⣿⣿⣷⡀⢼⣾⣿⢟⣿⡿⢿⣿⣿⣿⠀⣿⣿⣽⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⢀]],
	--   [[⣻⣿⣿⣿⣿⣿⣿⣦⣌⠓⠀⠙⢿⣿⢿⣿⣿⡿⣿⣿⡿⠃⢀⣾⡿⠃⢠⡿⣿⣿⢿⣿⢻⣿⠀⣿⣻⣿⣿⣿⣿⣿⢿⢿⣿⠀⣿⢻⣿⡿⠛⠛⠋⠉⠉⠀⢀⣀⣤⣾]],
	-- }
end

local asyncRunSetup = function()
	glo.asyncrun_open = 6
end

local asyncRunTaskSetup = function()
	glo.asynctasks_term_pos = "tmux"
	glo.asynctasks_term_pos = "TAB"
end

local nvimTreesitterSetup = function()
	local status, treessiterConf = pcall(require, "nvim-treesitter.configs")
	if not status then
		return
	end

	treessiterConf.setup({
		ensure_installed = { "lua", "python", "javascript" },
		highlight = {
			enable = true,
			disable = { "" },
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	})
end

local draculaSetup = function()
	local status, dracula = pcall(require, "dracula")
	if not status then
		return
	end
	dracula.setup({
		transparent_bg = true,
		italic_comment = true,
		overrides = {
			Normal = { fg = dracula.colors().white, bg = "None" },
		},
	})
end

local indentBlankLineSetup = function()
	local setup, _ = pcall(require, "indent_blankline")
	if not setup then
		return
	end
	glo.indent_blankline_char = "▏"
	glo.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "NvimTree" }
	glo.indent_blankline_buftype_exclude = { "terminal", "dashboard" }
	glo.indent_blankline_max_indent_increase = 2
	glo.indent_blankline_use_treesitter = true
	glo.indent_blankline_show_trailing_blankline_indent = false
	glo.indent_blankline_show_end_of_line = false
	glo.indent_blankline_show_first_indent_level = true
	require("indent_blankline").setup({
		space_char_blankline = " ",
		show_current_context = true,
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
	})
end

local luaLineSetup = function()
	local setup, _ = pcall(require, "lualine")
	if not setup then
		return
	end
	local custom_dracula = require("lualine.themes.dracula")
	custom_dracula.normal.c.bg = "#000"

	require("lualine").setup({
		options = {
			theme = custom_dracula,
			always_divide_middle = true,
			ignore_filetypes = { "dashboard", "NvimTree", "help" },
			ignore_focus = { "dashboard", "NvimTree", "help" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"branch",
					fmt = function(branch)
						-- get size of the current buffer
						local size = vim.fn.line("$")
						if size < 50 then
							if #branch > 15 then
								return string.sub(branch, 1, 15) .. "..."
							end
						end
						return branch
					end,
				},
				"diff",
				"diagnostics",
			},
			lualine_c = {
				{
					"filename",
					fmt = function(name)
						local se, lsp = pcall(require, "lspsaga.symbolwinbar")
						if se then
							return lsp:get_winbar()
						else
							return name
						end
					end,
				},
			},
			lualine_x = {},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

local todoCommentsSetup = function()
	local setup, _ = pcall(require, "todo-comments")
	if not setup then
		return
	end
	require("todo-comments").setup({
		keywords = {
			BUG = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "#f06caa" },
			WARN = { icon = " ", color = "#ffb86c", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "#9192ff", alt = { "INFO" } },
		},
	})
end

local nvimColorizerSetup = function()
	local setup, _ = pcall(require, "colorizer")
	if not setup then
		return
	end
	require("colorizer").setup()
end

local nvimWebDevIconsSetup = function()
	local setup, _ = pcall(require, "nvim-web-devicons")
	if not setup then
		return
	end
	require("nvim-web-devicons").setup()
	require("nvim-web-devicons").setup({
		override = {
			zsh = {
				icon = "",
				color = "#428850",
				cterm_color = "65",
				name = "Zsh",
			},
		},
		color_icons = true,
		default = true,
	})
end

local dressingSetup = function()
	local setup, _ = pcall(require, "dressing")
	if not setup then
		return
	end
	require("dressing").setup({
		input = {
			enabled = true,
			border = "rounded",
			win_options = {
				winblend = 10,
			},
		},
	})
end

local nvimSurroundSetup = function()
	local setup, _ = pcall(require, "nvim-surround")
	if not setup then
		return
	end
	require("nvim-surround").setup()
end

local autoPairsSetup = function()
	glo.AutoPairsFlyMode = 0
	glo.AutoPairsShortcutBackInsert = "<M-b>"
	glo.AutoPairsShortcutToggle = "<M-P>"
	glo.AutoPairsMultilineClose = 0
end

local commentNvimSetup = function()
	local setup, _ = pcall(require, "Comment")
	if not setup then
		return
	end
	require("Comment").setup()
end

local vimTranslatorSetup = function()
	glo.translator_target_lang = "english"
end

local grammarGuardSetup = function()
	local setup, grammar = pcall(require, "grammar-guard")
	if not setup then
		return
	end
	grammar.init()
end

local nvimTreeSetup = function()
	local setup, tree = pcall(require, "nvim-tree")
	if not setup then
		return
	end
	glo.loaded = 1
	glo.loaded_netrwPlugin = 1
	local function on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
		vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
		vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "a", api.fs.create, opts("Create"))
		vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
		vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
		vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
		vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
		vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
		vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		vim.keymap.set("n", "q", api.tree.close, opts("Close"))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
		vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
		vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
		vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
		vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	end

	tree.setup({
		auto_reload_on_write = true,
		on_attach = on_attach,
		diagnostics = { enable = false },
		actions = { use_system_clipboard = true },
		filters = {
			dotfiles = true,
			custom = {},
			exclude = {},
		},
	})
end

local telescopeSetup = function()
	local setup, telescope = pcall(require, "telescope")
	if not setup then
		return
	end
	telescope.setup({
		defaults = {
			prompt_prefix = "- 🐙 :",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "descending",
			scroll_strategy = "cycle",
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			use_less = true,
			layout_strategy = "horizontal",
			layout_config = {
				width = 0.95,
				prompt_position = "bottom",
				preview_cutoff = 10,
			},
		},
		mappings = {
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-q>"] = require("telescope.actions").send_to_qflist,
				["<space>x"] = require("telescope.actions").close,
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
	})
	pcall(telescope.load_extension, "fzf")
end

local gitSignsSetup = function()
	local setup, signs = pcall(require, "gitsigns")
	if not setup then
		return
	end
	signs.setup()
end

local vimCopilotSetup = function()
	glo.copilot_node_command = "~/.nvm/versions/node/v16.15.0/bin/node"
	glo.copilot_no_tab_map = true
	glo.copilot_assume_mapped = true
	glo.copilot_tab_fallback = ""
	glo.copilot_filetypes = {
		["dap-repl"] = false,
		["dapui_watches"] = false,
	}
end

local vimTmuxNavigationSetup = function()
	glo.tmux_navigator_no_mappings = 1
end

local hopSetup = function()
	local setup, _ = pcall(require, "hop")
	if not setup then
		return
	end
	require("hop").setup()
end

local neoscrollSetup = function()
	local setup, _ = pcall(require, "neoscroll")
	if not setup then
		return
	end
	require("neoscroll").setup()
end

local vimMoveSetup = function()
	glo.move_key_modifier = "A"
	glo.move_key_modifier_visualmode = "A"
end

local minimapSetup = function()
	glo.minimap_highlight_range = true
end

local vimGSetup = function()
	if os ~= "Mac" then
		glo.vim_g_open_command = "xdg-open"
	end
	glo.vim_g_python_command = "python3"
	glo.vim_g_query_url = "https://duckduckgo.com/?q="
end

local vimGodotSetup = function()
	glo.godot_executable = "/Applications/Godot.app/Contents/MacOS/Godot"
end

local nvimTsAutotagSetup = function()
	local setup, _ = pcall(require, "nvim-ts-autotag")
	if not setup then
		return
	end
	require("nvim-ts-autotag").setup()
end

local neotestSetup = function()
	local setup, _ = pcall(require, "neotest")
	if not setup then
		return
	end
	require("neotest").setup({
		adapters = {
			require("neotest-jest")({
				jestCommand = "npm test --",
				jestConfigFile = "custom.jest.config.ts",
				env = { CI = true },
				cwd = function()
					return vim.fn.getcwd()
				end,
			}),
		},
		icons = {
			child_indent = "│",
			child_prefix = "├",
			collapsed = "─",
			expanded = "╮",
			failed = "ﮗ",
			final_child_indent = " ",
			final_child_prefix = "╰",
			non_collapsible = "─",
			passed = "",
			running = "ﯦ",
			running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
			skipped = "ﮮ",
			unknown = "?",
		},
	})
end

local nvimDapVscodeJsSetup = function()
	local setup, _ = pcall(require, "dap-vscode-js")
	if not setup then
		return
	end
	require("dap-vscode-js").setup({
		adapters = { "pwa-node", "pwa-chrome", "node-terminal", "pwa-extensionHost" },
	})
end

local nvimDapUiSetup = function()
	local setup, _ = pcall(require, "dapui")
	if not setup then
		return
	end
	require("dapui").setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		expand_lines = true,
	})
end

local lspSagaConfig = function()
	local setup, saga = pcall(require, "lspsaga")
	if not setup then
		return
	end

	saga.setup({
		symbol_in_winbar = {
			enable = false,
			separator = " ",
			ignore_patterns = {},
			hide_keyword = true,
			show_file = true,
			folder_level = 2,
			respect_root = false,
			color_mode = true,
		},
		lightbulb = { enable = false },
		definition = {
			edit = "<space>o",
			vsplit = "<space>sv",
			split = "<space>sh",
			tabe = "<space>t",
			quit = "<space>x",
			back = "<space>b",
			next = "<space>n",
		},
		code_actions = {
			show_server_name = true,
		},
	})
end

----------------------------------------------------
-- plugins installation
----------------------------------------------------
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

local status, packer = pcall(require, "packer")
if not status then
	return
end

packer.init({
	luarocks = {
		python_cmd = "python3",
	},
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

----------------------------------------------------
-- plugins installation
----------------------------------------------------
packer.startup(function(use)
	if Packer_bootstrap then
		packer.sync()
	end

	-- INTERNALS
	use({ "wbthomason/packer.nvim" })
	use({ "skywind3000/asyncrun.vim", config = asyncRunSetup() })
	use({
		"skywind3000/asynctasks.vim",
		config = asyncRunTaskSetup(),
		requires = { "skywind3000/asyncrun.vim", "preservim/vimux" },
	})
	use({ "zhimsel/vim-stay" })

	-- COSMETICS
	use({ "glepnir/dashboard-nvim", config = dashboardSetup() })
	use({ "nvim-treesitter/nvim-treesitter", config = nvimTreesitterSetup(), run = ":TSUpdate" })
	use({ "Mofiqul/dracula.nvim", config = draculaSetup() })
	use({ "lukas-reineke/indent-blankline.nvim", config = indentBlankLineSetup() })
	use({
		"nvim-lualine/lualine.nvim",
		config = luaLineSetup(),
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "folke/todo-comments.nvim", config = todoCommentsSetup(), requires = "nvim-lua/plenary.nvim" })
	use({ "norcalli/nvim-colorizer.lua", config = nvimColorizerSetup() })
	use({ "nvim-tree/nvim-web-devicons", config = nvimWebDevIconsSetup() })
	use({ "stevearc/dressing.nvim", config = dressingSetup() })

	-- EDITING TOOLS
	use({ "kylechui/nvim-surround", config = nvimSurroundSetup(), tag = "*" })
	use({ "jiangmiao/auto-pairs", config = autoPairsSetup() })
	use({ "tpope/vim-repeat" })
	use({ "KabbAmine/vCoolor.vim" })
	use({ "numToStr/Comment.nvim", config = commentNvimSetup() })
	use({ "voldikss/vim-translator", config = vimTranslatorSetup() })
	use({ "mbbill/undotree" })
	-- use({ "brymer-meneses/grammar-guard.nvim", config = grammarGuardSetup(), requires = { "neovim/nvim-lspconfig" } })

	-- FILE MANAGEMENT
	use({ "nvim-tree/nvim-tree.lua", config = nvimTreeSetup(), requires = { "kyazdani42/nvim-web-devicons" } })
	use({
		"nvim-telescope/telescope.nvim",
		config = telescopeSetup(),
		requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- NAVIGATION
	use({ "christoomey/vim-tmux-navigator", config = vimTmuxNavigationSetup() })
	use({ "phaazon/hop.nvim", config = hopSetup() })
	use({ "karb94/neoscroll.nvim", config = neoscrollSetup() })
	use({ "matze/vim-move", config = vimMoveSetup() })
	use({ "wfxr/minimap.vim", config = minimapSetup() })
	use({ "szw/vim-g", config = vimGSetup() })
	use({ "szw/vim-maximizer" })

	-- GIT
	use({ "tpope/vim-fugitive" })
	use({ "lewis6991/gitsigns.nvim", config = gitSignsSetup() })
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- COPILOT
	use({ "github/copilot.vim", config = vimCopilotSetup() })

	-- SNIPPETS
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
	use({ "rafamadriz/friendly-snippets" })
	use({ "blitmap/lua-snippets" })

	-- LANGUAGE SPECIFIC
	use({ "habamax/vim-godot", config = vimGodotSetup() })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({ "styled-components/vim-styled-components" })
	use({ "windwp/nvim-ts-autotag", config = nvimTsAutotagSetup() })

	-- COMPLETION
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "f3fora/cmp-spell" })
	use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })
	use({ "saadparwaiz1/cmp_luasnip" })

	-- LINT
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "jayp0521/mason-null-ls.nvim" })

	-- DEBUGGING
	use({ "mfussenegger/nvim-dap" })
	use({
		"nvim-neotest/neotest",
		config = neotestSetup(),
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
	})
	use({ "mxsdev/nvim-dap-vscode-js", config = nvimDapVscodeJsSetup(), requires = { "mfussenegger/nvim-dap" } })
	use({ "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile" })
	use({ "rcarriga/nvim-dap-ui", config = nvimDapUiSetup(), requires = { "mfussenegger/nvim-dap" } })

	-- LSP (CONFIG IN DADICATED FILE LSP)
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })
	use({
		"glepnir/lspsaga.nvim",
		config = lspSagaConfig(),
		branch = "main",
		requires = { { "nvim-tree/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
	})
	use({ "jose-elias-alvarez/typescript.nvim" })
	use({ "onsails/lspkind.nvim" })

	-- OVER OBSERVATION
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
	use({ "ray-x/lsp_signature.nvim" })
	use({ "ixru/nvim-markdown" })
	use({ "barreiroleo/ltex-extra.nvim" })
	use({ "kamykn/spelunker.vim", requires = { "kamykn/popup-menu.nvim" } })
	use({ "preservim/vim-pencil" })
	use({ "lervag/vimtex" })
	use({ "vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim" })
	use({
		"jackMort/ChatGPT.nvim",
		requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	})
end)

----------------------------------------------------
-- OVER OBSERVATION configs
----------------------------------------------------
--chatgpt config
local chatsetup, chatgpt = pcall(require, "chatgpt")
if chatsetup then
	chatgpt.setup({
		welcome_message = WELCOME_MESSAGE,
		loading_text = "loading",
		question_sign = "", -- you can use emoji if you want e.g. 🙂
		answer_sign = "ﮧ", -- 🤖
		max_line_length = 120,
		yank_register = "+",
		chat_layout = {
			relative = "editor",
			position = "50%",
			size = {
				height = "80%",
				width = "80%",
			},
		},
		settings_window = {
			border = {
				style = "rounded",
				text = {
					top = " Settings ",
				},
			},
		},
		popup_input = {
			submit = "<C-s>",
		},
		chat_window = {
			filetype = "chatgpt",
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top = " ChatGPT ",
				},
			},
		},
		chat_input = {
			prompt = "  ",
			border = {
				highlight = "FloatBorder",
				style = "rounded",
				text = {
					top_align = "center",
					top = " Prompt ",
				},
			},
		},
		openai_params = {
			model = "gpt-3.5-turbo",
			frequency_penalty = 0,
			presence_penalty = 0,
			max_tokens = 300,
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		openai_edit_params = {
			model = "code-davinci-edit-001",
			temperature = 0,
			top_p = 1,
			n = 1,
		},
		chat = {
			keymaps = {
				close = { "<C-c>" },
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				toggle_settings = "<C-o>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				-- in the Sessions pane
				select_session = "<Space>",
				rename_session = "r",
				delete_session = "d",
			},
		},
		keymaps = {
			close = { "<C-c>" },
			yank_last = "<C-y>",
			yank_last_code = "<C-k>",
			scroll_up = "<C-u>",
			scroll_down = "<C-d>",
			toggle_settings = "<C-o>",
			new_session = "<C-n>",
			cycle_windows = "<Tab>",
			-- in the Sessions pane
			select_session = "<Space>",
			rename_session = "r",
			delete_session = "d",
		},
	})
end

-- package-info
vim.api.nvim_set_keymap(
	"n",
	"<leader>ns",
	"<cmd>lua require('package-info').show()<cr>",
	{ silent = true, noremap = true }
)

--vimtex
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
-- vim.g.vimtex_view_skim_sync = 1
-- vim.g.vimtex_view_skim_activate = 1

-- vim pencil
vim.g["pencil#autoformat"] = 0

-- spelunker
glo.enable_spelunker_vim = 0

-- lsp signature
local lsetup, lsp_signature = pcall(require, "lsp_signature")
if lsetup then
	lsp_signature.setup({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = false,
		transparency = 50,
		floating_window = false,
		toggle_key = "<M-f>",
	})
end

local tosetup, toggletasks = pcall(require, "toggletasks")
if tosetup then
	toggletasks.setup({
		debug = false,
		silent = false,
		short_paths = true,
		search_paths = {
			"nvimTasks",
			".nvimTasks",
			".nvim/toggletasks",
		},
		scan = {
			global_cwd = true,
			tab_cwd = true,
			win_cwd = true,
			lsp_root = true,
			dirs = {},
			rtp = false,
			rtp_ftplugin = false,
		},
		tasks = {},
		lsp_priorities = {
			["null-ls"] = -10,
		},
		toggleterm = {
			close_on_exit = false,
			hidden = true,
		},
		telescope = {
			spawn = {
				open_single = true,
				show_running = true,
				mappings = {
					select_float = "<C-f>",
					spawn_smart = "<C-a>",
					spawn_all = "<M-a>",
					spawn_selected = nil,
				},
			},
			select = {
				mappings = {
					select_float = "<C-f>",
					open_smart = "<C-a>",
					open_all = "<M-a>",
					open_selected = nil,
					kill_smart = "<C-q>",
					kill_all = "<M-q>",
					kill_selected = nil,
					respawn_smart = "<C-s>",
					respawn_all = "<M-s>",
					respawn_selected = nil,
				},
			},
		},
	})
	require("telescope").load_extension("toggletasks")
end
