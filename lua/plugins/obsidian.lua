return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/Notes/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Notes/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	completion = {
		nvim_cmp = true,
		min_chars = 2,
	},
	config = function()
		-- INFO: keymaps
		MAPKEY("n", "<leader>od", ":ObsidianDailies<CR>", { silent = true })
		MAPKEY("n", "<leader>op", ":ObsidianPasteImg<CR>", { silent = true })
		MAPKEY("n", "<leader>ot", ":ObsidianTags<CR>", { silent = true })
		MAPKEY("n", "<leader>os", ":ObsidianSearch<CR>", { silent = true })

		require("obsidian").setup({
			notes_subdir = "notes",
			new_notes_location = "notes_subdir",
			daily_notes = {
				folder = "notes/dailies",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
			},
			attachments = {
				img_folder = "data/notes",
			},
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will be given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,
			templates = {
				subdir = "notes/templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
			workspaces = {
				{
					name = "Notes",
					path = "~/Notes",
				},
			},
		})
	end,
}
