return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go", -- Go-specific config helper
  },
  config = function()
    local dap = require("dap")

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>dbs", "<cmd>lua require'dap'.savebp()<cr>", { desc = "save breakpoints" })
    keymap.set("n", "<leader>dbl", "<cmd>lua require'dap'.loadbp()<cr>", { desc = "load breakpoints" })
    keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "continue to the next breakpoint" })
    keymap.set("n", "<leader>dT", "<cmd>DapTerminate<cr>", { desc = "list frames" })
    keymap.set("n", "<leader>dj", "<cmd>DapStepInto<cr>", { desc = "step into the function" })
    keymap.set("n", "<leader>dl", "<cmd>DapStepOver<cr>", { desc = "step over the function" })
    keymap.set("n", "<leader>dk", "<cmd>DapStepOut<cr>", { desc = "step out of the function" })
    keymap.set("n", "<leader>de", "<cmd>DapToggleRepl<cr>:lua require'dap'.dapcli()<cr>", {desc = "toggle dap interactive command line" })
    keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.restart()<cr>", { desc = "step out of the function" })
    keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "toggle breakpoint at current line" })
    keymap.set("n", "<leader>dv", "<cmd>FzfLua dap_variables<cr>", { desc = "list current frame variables" })
    keymap.set("n", "<leader>df", "<cmd>FzfLua dap_frames<cr>", { desc = "list frames" })
    keymap.set("n", "<leader>dp", "<cmd>FzfLua dap_breakpoints<cr>", { desc = "list breakpoints" })
    -- 'h' -> Here
    keymap.set("n", "<leader>dh", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "run to current cursor position" })

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

    dap.savebp = function()
      local all_bpts = require("dap.breakpoints").get()
      if #all_bpts == 0 then
        return
      end

      local filename = vim.fn.stdpath("cache") .. "/gdbbreakpoints.txt"
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
      local filename = vim.fn.stdpath("cache") .. "/gdbbreakpoints.txt"
      local file = io.open(filename, "r")
      if file == nil then
        vim.notify(string.format("cannot open file: %s", filename), vim.log.levels.ERROR)
        return
      end

      -- breakpt = require("dap.breakpoints")
      for line in file:lines() do
        -- local bufnr = 0
        -- local lnum = 1
        local m = string.gmatch(line, "[^:]+")
        local bpfile = m()
        local lnum = m()
        print("breakpoint at line " .. lnum .. " of file " .. bpfile)
        -- breakpt.set({}, bufnr, lnum)
      end

      file:close()
    end

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
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
          return vim.fn.input("args: ")
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

    dap.configurations.cpp = {
      {
        name = "launch",
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
        name = "attach",
        type = "gdb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        stopAtBeginningOfMainSubprogram = false,
      },
    }

    require("dap-go").setup()
  end,
}
