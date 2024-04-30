return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "continue to the next breakpoint" })
    keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>", { desc = "list frames" })
    keymap.set("n", "<leader>di", "<cmd>DapStepInto<cr>", { desc = "step into the function" })
    keymap.set("n", "<leader>dj", "<cmd>DapStepOver<cr>", { desc = "step over the function" })
    keymap.set("n", "<leader>do", "<cmd>DapStepOut<cr>", { desc = "step out of the function" })
    keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.restart()<cr>", { desc = "step out of the function" })
    keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "toggle breakpoint at current line" })
    keymap.set("n", "<leader>dv", "<cmd>FzfLua dap_variables<cr>", { desc = "list current frame variables" })
    keymap.set("n", "<leader>df", "<cmd>FzfLua dap_frames<cr>", { desc = "list frames" })
    keymap.set("n", "<leader>dp", "<cmd>FzfLua dap_breakpoints<cr>", { desc = "list breakpoints" })

    -- As of gdb 14.1, gdb has itw own Debugger Adapter Protocol.
    -- This feature is turned on if gdb built with python support.
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      -- `gdb -i dap` command starts the dap server
      args = { "-i", "dap" }
    }

    dap.configurations.c = {
      {
          name = "launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          stopAtBeginningOfMainSubprogram = false,
      },
      {
          name = "attach",
          type = "gdb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          stopAtBeginningOfMainSubprogram = false,
      },
    }
  end,
}
