return {
	-- { "xiyaowong/transparent.nvim" },
	{
		"EdenEast/nightfox.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			vim.cmd.colorscheme("nightfox")
		end,
		opts = {
			options = {
				transparent = true,
			},
			palettes = {
				all = {
					bg0 = "NONE",
					bg3 = "NONE",
				},
			},
			groups = {
				all = {
					Normal = { bg = "NONE" },
					NormalFloat = { bg = "NONE" },
					FloatBorder = { bg = "NONE" },
					Pmenu = { bg = "NONE" },
					Whitespace = { link = "Conceal" },
					WinSeparator = { link = "Conceal" },
				},
			},
		},
	},
	{
		"catgoose/nvim-colorizer.lua",
		opts = {
			filetypes = {
				"css",
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"javascript.jsx",
				"typescriptreact",
				"typescript.tsx",
			},
			options = {
				display = { mode = "background" },
			},
		},
	},
}
