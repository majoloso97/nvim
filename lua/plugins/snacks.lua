local function refine_picker(picker)
	local items = picker:items()
	if #items == 0 then
		Snacks.notify.warn("No picker results to refine")
		return
	end

	-- Freeze the current result set so the next query narrows these items only.
	local results = vim.deepcopy(items)
	picker.finder._find = function()
		return vim.deepcopy(results)
	end
	picker.opts.live = false
	picker.input:set("", "")
	picker:find({ refresh = true })
end

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			input = { enabled = true },
			image = {
				enabled = true,
				convert = { notify = true },
			},
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			picker = {
				layout = "telescope",
				ui_select = true,
				actions = {
					refine = refine_picker,
				},
				win = {
					input = {
						keys = {
							["<c-f>"] = { "refine", mode = { "i", "n" } },
							["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-n>"] = { "list_scroll_down", mode = { "i", "n" } },
							["<c-p>"] = { "list_scroll_up", mode = { "i", "n" } },
							["<c-j>"] = { "list_down", mode = { "i", "n" } },
							["<c-k>"] = { "list_up", mode = { "i", "n" } },
						},
					},
					list = {
						keys = {
							["<c-d>"] = "preview_scroll_down",
							["<c-u>"] = "preview_scroll_up",
							["<c-n>"] = "list_scroll_down",
							["<c-p>"] = "list_scroll_up",
							["<c-j>"] = "list_down",
							["<c-k>"] = "list_up",
						},
					},
					preview = {
						keys = {
							["<c-d>"] = "preview_scroll_down",
							["<c-u>"] = "preview_scroll_up",
						},
					},
				},
			},
			styles = {
				input = { relative = "cursor" },
			},
		},
		keys = {
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
			{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
			{ "<leader>st", function() Snacks.picker.pickers() end, desc = "[S]earch [T]ools" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
			{ "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
			{ "<leader>s.", function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
			{ "<leader><leader>", function() Snacks.picker.buffers() end, desc = "[ ] Find existing buffers" },
			{
				"<leader>sm",
				function()
					Snacks.picker.files({
						title = "Media Files",
						ft = { "png", "jpg", "gif", "mp4", "webm", "pdf" },
						confirm = function(picker, item)
							local path = Snacks.picker.util.path(item)
							if path then
								vim.fn.setreg(vim.v.register, path)
								vim.notify("The media path has been copied!")
							end
							picker:close()
						end,
					})
				end,
				desc = "Find media files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.lines({ preview = false, layout = { preset = "dropdown" } })
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{ "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "[S]earch [/] in Open Files" },
			{
				"<leader>sn",
				function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
				desc = "[S]earch [N]eovim files",
			},
			{
				"<leader>lc",
				function()
					Snacks.bufdelete.delete()
				end,
				desc = "Close current buffer (no layout change)",
			},
			-- {
			-- 	"gsp",
			-- 	function()
			-- 		Snacks.picker.lsp_references()
			-- 	end,
			-- 	nowait = true,
			-- 	desc = "References",
			-- },
		},
	},
}
