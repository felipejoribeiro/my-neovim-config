return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/notes/**.md",
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
			notes_subdir = "fleeting",
			new_notes_location = "notes_subdir",
			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
			},
			attachments = {
				img_folder = "assets/notes",
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](../%s)", path.name, path)
				end,
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
				subdir = "assets/templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				-- A map for custom variables, the key should be the variable and the value a function
				substitutions = {},
			},
			workspaces = {
				{
					name = "Notes",
					path = "~/notes",
				},
			},
		})
	end,
}
