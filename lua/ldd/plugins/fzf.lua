return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>fo", "<cmd>FzfLua buffers<cr>", { desc = "find opened files" })
    -- this allow me to search by "string_to_array -- *.sql"
    keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep_glob<cr>", { desc = "search string with pattern" })
    keymap.set("n", "<leader>fl", "<cmd>FzfLua resume<cr>", { desc = "show last FzfLua command result" })
    keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>", { desc = "Find string under cursor in cwd" })

    keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "search symbol in workspace" })
    keymap.set("n", "<leader>lf", "<cmd>FzfLua lsp_finder<cr>", { desc = "find symbol under cursor" })
  end
}
