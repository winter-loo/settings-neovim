return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup {
        -- keymap for :ToggleTerm
        open_mapping = [[<c-\><c-\>]],
        -- the :ToggleTerm keymap also works in Insert mode
        insert_mappings = true,
        -- start Insert mode when terminal opens up
        start_in_insert = true,
      }

      vim.keymap.set('n', [[\]], "<cmd>ToggleTerm direction=float<cr>",
        { desc = "toggle floating terminal" })

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })

      function ToggleLazygit()
        lazygit:toggle()
      end

      vim.keymap.set("n", "<leader>g", "<cmd>lua ToggleLazygit()<CR>")
    end
  }
}
