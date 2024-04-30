return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

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
