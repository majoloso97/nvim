return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			treesitter.install({
				"bash",
				"c",
				"diff",
				"go",
				"gitcommit",
				"html",
				"javascript",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"regex",
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"bash",
					"c",
					"diff",
					"go",
					"gitcommit",
					"html",
					"javascript",
					"javascriptreact",
					"lua",
					"markdown",
					"python",
					"typescript",
					"typescriptreact",
					"vim",
					"vimdoc",
				},
				callback = function(args)
					vim.treesitter.start(args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
