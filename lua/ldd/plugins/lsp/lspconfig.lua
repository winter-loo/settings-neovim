return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- will search configuration in 'lsp/cpp.lua'
    vim.lsp.enable('cpp')
    -- will search configuration in 'lsp/lua.lua'
    vim.lsp.enable('lua')

    -- for web development
    -- syntax highlight: `:TSInstall html`
    -- syntax highlight: `:TSInstall typescript`
    -- syntax highlight: `:TSInstall svelte`
    -- vtsls for typescript and javascript
    vim.lsp.enable({'html', 'cssls', 'vtsls', 'svelte'})

    -- golang
    vim.lsp.enable('gopls')

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

        -- <gi> is a built-in keymap for 'goto insert'
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations<CR>", opts) -- show lsp implementations

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

        opts.desc = "show lsp symbols in this file"
        keymap.set("n", "<leader>ll", "<cmd>FzfLua lsp_document_symbols<CR>", opts)
      end,
    })
  end,
}
