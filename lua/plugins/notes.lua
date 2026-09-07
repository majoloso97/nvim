return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/vaults/personal/",
			},
			{
				name = "finance",
				path = "~/Documents/vaults/personal/finance/",
				strict = true,
			},
			{
				name = "journal",
				path = "~/Documents/vaults/personal/journal/",
				strict = true,
			},
			{
				name = "work",
				path = "~/Documents/vaults/work/",
			},
			{
				name = "learning",
				path = "~/Documents/vaults/work/learning/",
				strict = true,
			},
			{
				name = "noble",
				path = "~/Documents/vaults/work/noble/",
				strict = true,
			},
			{
				name = "lpm",
				path = "~/Documents/vaults/work/lpm/",
				strict = true,
			},
		},
	},
}
