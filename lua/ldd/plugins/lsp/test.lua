return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "fredrikaverpil/neotest-golang", version = "*" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				-- must install a debug adapter server first, such as codelldb
				require("rustaceanvim.neotest"),
				-- must install a debug adapter server first, such as delve
				require("neotest-golang")({}),
			},
			log_level = "debug",
		})
	end,
	keys = function()
		return {
			{
				"<leader>tt",
				"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run()<CR>",
				desc = "run this test code nearest cursor",
			},
			{
				"<leader>tl",
				"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run_last()<CR>",
				desc = "test the last tested case",
			},
			{
				"<leader>dt",
				"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run_last({ strategy = 'dap' })<CR>",
				desc = "debug last tested code",
			},
			{
				"<leader>tf",
				"<cmd>lua neotest=require('neotest') neotest.output_panel.clear() neotest.run.run(vim.fn.expand('%'))<CR>",
				desc = "run tests in file",
			},
			{ "<leader>te", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "show test cases explorer" },
			{
				"<leader>to",
				"<cmd>lua require'neotest'.output_panel.toggle()<CR>",
				desc = "toggle the testing output panel",
			},
		}
	end,
}
