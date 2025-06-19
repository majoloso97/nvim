-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("ConformFormatters", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local formatters = require("conform").list_formatters_to_run(bufnr)
	local win_opts = {
		style = "minimal",
		relative = "editor",
		height = 40,
		width = 150,
		col = 18,
		row = 6,
	}
	local ns = vim.api.nvim_create_namespace("conform_float")
	local buff = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buff, true, win_opts)

	local lines = {
		" Press q or <Esc> to close this window.",
		"",
		" Log file: /Users/marvin/.local/state/nvim/conform.log",
		" Detected filetype:   " .. vim.bo[bufnr].filetype,
		"",
	}

	local highlights = {}
	local set_highlight = function(args)
		vim.api.nvim_buf_add_highlight(buff, ns, args.hl_group, args.line, args.start_col, args.end_col)
	end
	local initial_linenr = 7
	if not formatters or vim.tbl_isempty(formatters) then
		table.insert(lines, " No formatters available.")
	else
		table.insert(lines, " " .. #formatters .. " formatter(s) available for this buffer: ")
		table.insert(lines, "")
		for _, formatter in ipairs(formatters) do
			local is_available = formatter.available and "true" or "false"

			table.insert(lines, " Client: " .. formatter.name .. " (bufnr: [" .. bufnr .. "])")
			table.insert(lines, "  available:       " .. is_available)
			table.insert(lines, "  command:         " .. formatter.command)
			table.insert(lines, "")

			table.insert(highlights, {
				client = {
					hl_group = "Title",
					line = initial_linenr,
					start_col = 9,
					end_col = 9 + string.len(formatter.name),
				},
				available = {
					hl_group = formatter.available and "Character" or "Error",
					line = initial_linenr + 1,
					start_col = 19,
					end_col = -1,
				},
				command = {
					hl_group = "NotifyWARNTitle",
					line = initial_linenr + 2,
					start_col = 19,
					end_col = -1,
				},
			})
			initial_linenr = initial_linenr + 4
		end
	end

	vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)
	vim.api.nvim_set_option_value("modifiable", false, { buf = buff })

	vim.api.nvim_buf_add_highlight(buff, ns, "Comment", 0, 0, -1)
	vim.api.nvim_buf_add_highlight(buff, ns, "NotifyWARNTitle", 3, 22, -1)

	for _, hl in ipairs(highlights) do
		set_highlight(hl.client)
		set_highlight(hl.available)
		set_highlight(hl.command)
	end

	-- Keymaps to close the window
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buff, nowait = true, silent = true })

	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buff, nowait = true, silent = true })
end, { desc = "Formatter Info" })
