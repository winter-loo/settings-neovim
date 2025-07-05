-- HINT: You could use neovim built-in debugging plugin
-- :packadd termdebug
-- :help terminal-debug
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go", -- Go-specific config helper
		"ibhagwan/fzf-lua",
	},
	config = function()
		local dap = require("dap")

		local keymap = vim.keymap -- for conciseness

		vim.fn.sign_define(
			"DapStopped",
			{ text = "▶", texthl = "DiagnosticError", linehl = "DiagnosticError", numhl = "" }
		)
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◐", texthl = "DiagnosticError", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "○", texthl = "DiagnosticError" })

		-- As of gdb 14.1, gdb has itw own Debugger Adapter Protocol.
		-- This feature is turned on if gdb built with python support.
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			-- `gdb -i dap` command starts the dap server
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}

		dap.configurations.c = {
			{
				name = "gdb launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = function()
					return vim.fn.input("args: ")
				end,
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "gdb attach",
				type = "gdb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "lldb launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = function()
					return vim.fn.input("args: ")
				end,
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "lldb attach",
				type = "codelldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				stopAtBeginningOfMainSubprogram = false,
			},
		}

		dap.configurations.cpp = dap.configurations.c

		require("dap-go").setup()
	end,
	keys = function()
		local dap = require("dap")

		dap.savebp = function()
			local all_bpts = require("dap.breakpoints").get()
			if #all_bpts == 0 then
				return
			end

			local filename = vim.fn.stdpath("cache") .. "/gdb.breakpoints"
			local file = io.open(filename, "w")
			if file == nil then
				vim.notify(string.format("cannot open file: %s", filename), vim.log.levels.ERROR)
				return
			end

			for bufnr, bpts in pairs(all_bpts) do
				for _, bp in ipairs(bpts) do
					file:write(vim.fn.bufname(bufnr) .. ":" .. bp.line .. "\n")
				end
			end
			file:close()
			vim.notify(string.format("breakpoints saved to file %s", filename), vim.log.levels.INFO)
		end

		dap.loadbp = function()
			local filename = vim.fn.stdpath("cache") .. "/gdb.breakpoints"
			local file = io.open(filename, "r")
			if file == nil then
				vim.notify(string.format("cannot open file: %s", filename), vim.log.levels.ERROR)
				return
			end

			breakpt = require("dap.breakpoints")
			for line in file:lines() do
				-- local bufnr = 0
				-- local lnum = 1
				local m = string.gmatch(line, "[^:]+")
				local bpfile = m()
				local lnum = m()
				print("breakpoint at line " .. lnum .. " of file " .. bpfile)
				breakpt.set({}, bufnr, lnum)
			end

			file:close()
		end

		dap.dapcli = function()
			local tabh = vim.api.nvim_win_get_tabpage(0)
			for _, w in ipairs(vim.api.nvim_tabpage_list_wins(tabh)) do
				local b = vim.api.nvim_win_get_buf(w)
				local bufname = vim.api.nvim_buf_get_name(b)
				-- get '[dap-repl]' from '/home/ldd/some/path/[dap-repl]'
				local fname = string.match(bufname, "/.*/(.*)")
				if fname then
					if vim.fn.buflisted(b) ~= 1 and fname == "[dap-repl]" then
						-- switch to '[dap-repl]' buffer and enter 'insert' mode
						vim.api.nvim_set_current_win(w)
						vim.api.nvim_win_set_height(w, 10)
						vim.api.nvim_input("i")
						break
					end
				end
			end
		end

		return {
			{ "<leader>dbb", dap.toggle_breakpoint, desc = "toggle breakpoint" },
			{ "<leader>dbS", dap.savebp, desc = "Save breakpoints" },
			{ "<leader>dbL", dap.loadbp, desc = "Load breakpoints" },
			{
				"<leader>dbl",
				function()
					vim.ui.input({ prompt = "Log point message: " }, function(input)
						dap.set_breakpoint(nil, nil, input)
					end)
				end,
				desc = "Toggle Logpoint",
			},
			{
				"<leader>dbc",
				function()
					vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
						dap.set_breakpoint(input)
					end)
				end,
				desc = "Conditional Breakpoint",
			},
			{ "<leader>dc", dap.continue, desc = "continue to the next breakpoint" },
			{ "<leader>dT", dap.terminate, desc = "terminate debug session" },
			{ "<leader>dj", dap.step_into, desc = "step into the function" },
			{ "<leader>dl", dap.step_over, desc = "step over the function" },
			{ "<leader>dk", dap.step_out, desc = "step out of the function" },
			{ "<leader>drl", dap.run_last, desc = "Run Last" },
			{
				"<leader>de",
				function()
					dap.repl.toggle()
					dap.dapcli()
				end,
				desc = "toggle dap interactive command line",
			},
			{ "<leader>dr", dap.restart, desc = "step out of the function" },
			{ "<leader>dh", dap.run_to_cursor, desc = "run to current cursor position" },
			{
				"<leader>dv",
				function()
					require("fzf-lua").dap_variables()
				end,
				desc = "list current frame variables",
			},
			{
				"<leader>df",
				function()
					require("fzf-lua").dap_frames()
				end,
				desc = "list frames",
			},
			{
				"<leader>dp",
				function()
					require("fzf-lua").dap_breakpoints()
				end,
				desc = "list breakpoints",
			},
		}
	end,
}
