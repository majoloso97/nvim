return {
	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			ignore_filetypes = { text = true },
			log_level = "info",
			disable_inline_completion = true,
			disable_keymaps = true,
		},
	},
	{
		"sudo-tee/opencode.nvim",
		opts = {
			default_mode = "plan",
			preferred_picker = "snacks",
			preferred_completion = "blink",
			keymap = {
				editor = {
					["<leader>oc"] = { "quick_chat", mode = { "n", "x" } },
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					anti_conceal = { enabled = false },
					file_types = { "markdown", "opencode_output" },
				},
				ft = { "markdown", "opencode_output" },
			},
			"saghen/blink.cmp",
			"folke/snacks.nvim",
		},
	},
}
