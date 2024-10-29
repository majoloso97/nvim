local Plugins = {
	{ "tpope/vim-sleuth" },
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
	-- delete buffers with no change in layout
	{ "ojroques/nvim-bufdel", opts = { next = "cycle" } },
}

return Plugins
