return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			-- Change the default chat adapter
			chat = {
				adapter = {
					-- expose api key through environment variable GEMINI_API_KEY
					-- export GEMINI_API_KEY=xxxx
					name = "gemini",
					model = "gemini-2.5-flash",
				},
			},
			inline = {
				adapter = {
					name = "gemini",
					model = "gemini-2.5-flash",
				},
			},
			cmd = {
				adapter = {
					name = "gemini",
					model = "gemini-2.5-flash",
				},
			},
		},
	},
	keys = function()
		return {
			{ "gA", "ga", desc = "show ascii code" },
			-- this hides vim built-in `ga` keymap
			{ "ga", "V<cmd>CodeCompanionChat<CR>", desc = "ask AI with the current line" },
      { "ga", "<cmd>CodeCompanionChat<CR>", mode = "v", desc = "Ask AI about selection" },
		}
	end,
}
