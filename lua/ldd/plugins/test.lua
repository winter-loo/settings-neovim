return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	--
	vim.keymap.set(
		"n",
		"<leader>tt",
		"<cmd>TestNearest<CR>",
		{ desc = "run this test code nearest cursor" }
	),
	vim.keymap.set(
		"n",
		"<leader>tf",
		"<cmd>TestFile<CR>",
		{ desc = "run tests within current file" }
	),
	vim.keymap.set(
		"n",
		"<leader>tF",
		"<cmd>TestFile -strategy=vimux<CR>",
		{ desc = "run tests within current file in split tmux pane" }
	),
	vim.keymap.set(
		"n",
		"<leader>tT",
		"<cmd>TestNearest -strategy=vimux<CR>",
		{ desc = "run this test code nearest cursor in split tmux pane" }
	),
	vim.keymap.set(
		"n",
		"<leader>to",
		"<cmd>VimuxTogglePane<CR>",
		{ desc = "toggle the testing tmux pane" }
	),
	vim.keymap.set(
		"n",
		"<leader>tz",
		"<cmd>VimuxZoomRunner<CR>",
		{ desc = "zoom into the testing tmux pane" }
	),
	vim.keymap.set(
		"n",
		"<leader>tx",
		"<cmd>VimuxCloseRunner<CR>",
		{ desc = "close the testing tmux pane" }
	),
}
