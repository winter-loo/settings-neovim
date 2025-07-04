return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.lsp.config.clangd = {
      cmd = {
        -- If you have a custom installed clangd, you may need set
        -- your clangd full path.
        --
        -- And if you build clangd from source using custom installed g++,
        -- you may need set your g++ full path in ~/.config/clangd/config.yaml
        -- Example.
        -- ```config.yaml
        -- CompileFlags:
        --   Add: [-xc++, -Wall]   # treat all files as C++, enable more warnings
        --   Compiler: /data/ludd50155/alt/gcc-10.5.0/bin/g++
        -- ```
        --
        -- TIPS: you could have .clangd file in your project root and add some
        -- include directories or compilation flags in it.
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--offset-encoding=utf-8',
      },
    }
    vim.lsp.enable('clangd')

    -- see :help lsp
    vim.lsp.config['luals'] = {
      -- Command and arguments to start the server.
      cmd = { 'lua-language-server' },

      -- Filetypes to automatically attach to.
      filetypes = { 'lua' },

      -- Sets the "root directory" to the parent directory of the file in the
      -- current buffer that contains either a ".luarc.json" or a
      -- ".luarc.jsonc" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      -- Nested lists indicate equal priority, see |vim.lsp.Config|.
      root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },

      -- Specific settings to send to the server. The schema for this is
      -- defined by the server. For example the schema for lua-language-server
      -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          }
        }
      }
    }

    vim.lsp.enable('luals')

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts) -- show lsp definitions

        -- opts.desc = "Show LSP implementations"
        -- <gi> is a built-in keymap for 'goto insert'
        -- keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>FzfLua lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
        keymap.set("n", "<leader>cp", function()
          local ok = pcall(vim.cmd, "/^\\s\\+print")
          if ok then
            vim.cmd("norm V/;")
            vim.cmd("norm gc$")
          end
        end, { desc = "quickly comment the print statement" })
        keymap.set("n", "<leader>cP", function()
          local ok = pcall(vim.cmd, "/^\\s\\+\\/\\/ print")
          if ok then
            vim.cmd("norm V/;")
            vim.cmd("norm gc$")
          end
        end, { desc = "quickly uncomment the print statement" })

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>FzfLua lsp_document_diagnostics<CR>", opts) -- show  diagnostics for file

        -- opts.desc = "Show line diagnostics"
        -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

        opts.desc = "enable inlay hint"
        keymap.set("n", "<leader>ih",
          ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({0}), {0})<CR>", opts)
      end,
    })
  end,
}
