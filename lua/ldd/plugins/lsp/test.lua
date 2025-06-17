return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require('rustaceanvim.neotest')
      },
    })
  end,
	--
	vim.keymap.set(
		"n",
		"<leader>tt",
		"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run()<CR>",
		{ desc = "run this test code nearest cursor" }
	),
	vim.keymap.set(
		"n",
		"<leader>tl",
		"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run_last()<CR>",
		{ desc = "test the last tested case" }
	),
	vim.keymap.set(
		"n",
		"<leader>dt",
		"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run_last({ strategy = 'dap' })<CR>",
		{ desc = "debug last tested code" }
	),
	vim.keymap.set(
		"n",
		"<leader>tf",
		"<cmd>TestFile<CR>",
		{ desc = "lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run(vim.fn.expand('%'))" }
	),
	vim.keymap.set(
		"n",
		"<leader>te",
		"<cmd>lua require('neotest').summary.toggle()<CR>",
		{ desc = "show test cases explorer" }
	),
	vim.keymap.set(
		"n",
		"<leader>to",
		"<cmd>lua require'neotest'.output_panel.toggle()<CR>",
		{ desc = "toggle the testing output panel" }
	),
}
