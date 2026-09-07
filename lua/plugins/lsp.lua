return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by blink.cmp
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gh", vim.lsp.buf.hover, "Hover Documentation")
					map("gca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("gd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")
					map("gtd", Snacks.picker.lsp_type_definitions, "[G]oto [T]ype [D]efinition")
					map("gr", Snacks.picker.lsp_references, "[G]oto [R]eferences")
					map("gi", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
					map("gds", vim.lsp.buf.document_symbol, "[G]oto [D]ocument [S]ymbols")
					map("gws", vim.lsp.buf.workspace_symbol, "[G]oto [W]orkspace [S]ymbols")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/documentHighlight", event.buf) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			--  See `:help lsp-config` for information about keys and how to configure
			local servers = {
				clangd = {},
				sqlls = {},
				gopls = {},
				pyright = {
					-- Override nvim-lspconfig's bundled markers with the local project marker too.
					root_markers = {
						"pyrightconfig.json",
						"pyproject.toml",
						"setup.py",
						"setup.cfg",
						"requirements.txt",
						"Pipfile",
						"main.py",
						".git",
					},
				},
				jsonls = {},
				lua_ls = {},
				tsc = {},
				tailwindcss = {},
				cssls = {},
				html = {},
			}
			-- LSP servers (Mason package names)
			local ensure_installed = {
				"tsc", -- TypeScript 7 native language server
				"tailwindcss-language-server", -- for tailwindcss
				"json-lsp", -- for jsonls
				"lua-language-server", -- for lua_ls
				"gopls",
				"pyright",
				"clangd",
				"sqlls",
				"stylua",
			}

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, server in pairs(servers) do
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				vim.lsp.config(name, server)
				vim.lsp.enable(name)
			end
		end,
	},
}
