return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"folke/snacks.nvim",
		},
		opts = {
			integrations = {
				snacks = true,
			},
		},
	},
	{
		"f-person/git-blame.nvim",
		opts = {
			message_template = "  <date> | <author> | <summary> | <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%Y-%b-%d %H:%M",
		},
	},
	{
		"tronikelis/conflict-marker.nvim",
		lazy = false,
		opts = {
			highlights = true,
			on_attach = function(conflict)
				local map = function(key, method, description)
					vim.keymap.set("n", key, function()
						conflict[method](conflict)
					end, { buffer = conflict.bufnr, desc = description })
				end

				map("<leader>Go", "choose_ours", "Choose ours")
				map("<leader>Gt", "choose_theirs", "Choose theirs")
				map("<leader>Gb", "choose_both", "Choose both")
				map("<leader>Gx", "choose_none", "Choose none")
				vim.keymap.set("n", "<leader>Gp", function()
					vim.fn.search("^<<<<<<<", "b")
				end, { buffer = conflict.bufnr, desc = "Go to previous conflict" })
				vim.keymap.set("n", "<leader>Gn", function()
					vim.fn.search("^<<<<<<<")
				end, { buffer = conflict.bufnr, desc = "Go to next conflict" })
			end,
		},
	},
}
