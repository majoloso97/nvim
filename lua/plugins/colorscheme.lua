return {
	{ "xiyaowong/transparent.nvim" },
	{
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		"EdenEast/nightfox.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			vim.cmd.colorscheme("nightfox")
		end,
	},
}
