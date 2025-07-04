return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  config = function ()
    require("dapui").setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
    })
  end,
  keys = function ()
    local dapui = require("dapui")
    return {
      { "<leader>du", dapui.toggle, desc = "open debugger UI" }
    }
  end
}
