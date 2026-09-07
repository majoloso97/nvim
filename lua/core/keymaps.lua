local keymap = vim.keymap

keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

keymap.set("n", "<leader>g", "<cmd> Neogit<CR>", { desc = "Open Neogit home" })

keymap.set("n", "<leader>t", "<cmd> term<CR>", { desc = "Open terminal" })
keymap.set("n", "<leader>E", "<cmd> Ex<CR>", { desc = "Go to netrw explorer" })

keymap.set("n", "<leader>k", "<cmd> bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>j", "<cmd> bp<CR>", { desc = "Go to prev buffer" })

-- Layout keymaps
keymap.set("n", "<leader>lk", "<cmd> bd<CR>", { desc = "Close current buffer (layout change)" })
keymap.set("n", "<leader>lh", "<C-w><C-s>", { desc = "Split layout horizontally" })
keymap.set("n", "<leader>lv", "<C-w><C-v>", { desc = "Split layout vertically" })

-- LSP shortcuts
keymap.set("n", "<leader>Lr", "<cmd> LspRestart<CR>", { desc = "LSP Restart" })
keymap.set("n", "<leader>Li", "<cmd> LspInfo<CR>", { desc = "LSP Info" })
keymap.set("n", "<leader>Lf", "<cmd> ConformFormatters<CR>", { desc = "Formatter Info" })

-- Session keymaps
keymap.set("n", "<leader>Sp", "<cmd> SessionPurgeOrphaned <CR>", { desc = "[S]ession [p]urge orphaned" })

keymap.set("n", "<leader>n", "<cmd> Obsidian <CR>", { desc = "[O]bsidian" })
