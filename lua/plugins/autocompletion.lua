return {
	{
		"saghen/blink.compat",
		-- use v2.* for blink.cmp v1.*
		version = "2.*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghm/blink.cmp",
		version = "1.*",
		dependencies = {
			{ "supermaven-inc/supermaven-nvim" },
		},
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback", "fallback_to_mappings" },
				["<Tab>"] = { "accept", "fallback", "fallback_to_mappings" },
				["<S-CR>"] = { "accept_and_enter", "fallback", "fallback_to_mappings" },
			},
			completion = {
				list = { max_items = 20 },
				menu = {
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind", "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									if ctx.source_name == "supermaven" then
										return "" .. ctx.icon_gap
									end
									return ctx.kind_icon .. ctx.icon_gap
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 250,
				},
				-- ghost_text = {
				-- 	enabled = true,
				-- 	show_without_selection = true,
				-- },
			},
			fuzzy = {
				sorts = {
					"score",
					"sort_text",
					"label",
				},
			},
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"supermaven",
				},
				providers = {
					lsp = { score_offset = 1, fallbacks = {} },
					path = { score_offset = -1 },
					buffer = { score_offset = 0 },
					supermaven = {
						name = "supermaven",
						module = "blink.compat.source",
						score_offset = 100,
					},
				},
			},
		},
	},
}
