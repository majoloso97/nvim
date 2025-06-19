local keymap = vim.keymap

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap.set("n", "<leader>g", "<cmd> Neogit<CR>", { desc = "Open Neogit home" })
keymap.set("n", "<leader>G", "<cmd> GitConflictListQf<CR>", { desc = "Open list of Git Conflicts in Quick fix" })

keymap.set("n", "<leader>t", "<cmd> term<CR>", { desc = "Move focus to the upper window" })
keymap.set("n", "<leader>E", "<cmd> Ex<CR>", { desc = "Go to netrw explorer" })

keymap.set("n", "<leader>k", "<cmd> bn<CR>", { desc = "Go to next buffer (up in Telescope open buffers)" })
keymap.set("n", "<leader>j", "<cmd> bp<CR>", { desc = "Go to prev buffer (down in Telescope open buffers)" })

-- Layout keymaps
keymap.set("n", "<leader>lc", "<cmd> BufDel<CR>", { desc = "Close current buffer (no layout change)" })
keymap.set("n", "<leader>lk", "<cmd> bd<CR>", { desc = "Close current buffer (layout change)" })
keymap.set("n", "<leader>lh", "<C-w><C-s>", { desc = "Split layout horizontally" })
keymap.set("n", "<leader>lv", "<C-w><C-v>", { desc = "Split layout vertically" })

-- Allow optional custom session name passes to autosession cmds
local session_func = function(cmd)
	local session_name = vim.fn.input("Session name: ")
	if session_name == nil or session_name == "" then
		vim.cmd(cmd)
	else
		vim.cmd(cmd .. " " .. session_name)
	end
end

-- LSP shortcuts
keymap.set("n", "<leader>Lr", "<cmd> LspRestart<CR>", { desc = "LSP Restart" })
keymap.set("n", "<leader>Li", "<cmd> LspInfo<CR>", { desc = "LSP Info" })
keymap.set("n", "<leader>Lf", "<cmd> ConformFormatters<CR>", { desc = "Formatter Info" })

-- Session keymaps
keymap.set("n", "<leader>ss", "<cmd> SessionSearch <CR>", { desc = "[S]earch [S]ession" })
keymap.set("n", "<leader>Ss", "<cmd> SessionSearch <CR>", { desc = "[S]ession [S]earch" })
keymap.set("n", "<leader>Sp", "<cmd> SessionPurgeOrphaned <CR>", { desc = "[S]ession [p]urge orphaned" })
keymap.set("n", "<leader>Sw", function()
	session_func("SessionSave")
end, { desc = "[S]ession [w]rite (save)" })
keymap.set("n", "<leader>Sr", function()
	session_func("SessionRestore")
end, { desc = "[S]ession [r]estore" })
keymap.set("n", "<leader>Sd", function()
	session_func("SessionDelete")
end, { desc = "[S]ession [d]elete" })
