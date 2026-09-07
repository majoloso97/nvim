return {
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			allowed_dirs = { "~/.config/*", "~/Documents/*/*" },
			git_use_branch_name = true,
			git_auto_restore_on_branch_change = true,
			---@type SessionLens
			session_lens = {
				picker = "snacks",
				previewer = "summary", -- shows a summary of the session
				picker_opts = {
					preset = "telescope",
				}, -- Snacks layout options for the session picker

				---@type SessionLensMappings
				mappings = {
					delete_session = { { "i", "n" }, "<C-d>" }, -- mode and key for deleting a session from the picker
					alternate_session = { { "i", "n" }, "<C-s>" }, -- mode and key for swapping to alternate session from the picker
				},
			},
		},
		keys = {
			{ "<leader>wf", "<cmd>AutoSession search<CR>", desc = "Session search" },
			{ "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
			{ "<leader>wp", "<cmd>AutoSession purgeOrphaned<CR>", desc = "Purge Orphaned" },
			{ "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
		},
	},
}
