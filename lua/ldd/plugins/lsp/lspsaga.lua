return {
  "nvimdev/lspsaga.nvim",
  config = function()
    vim.api.nvim_set_hl(0, "WinBar", {
      bg = "#44475a", -- Dracula selection gray
    })
    require('lspsaga').setup({
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        in_custom = false,
        enable = true,
        separator = ' ',
        show_file = true,
        file_formatter = ""
      },
    })
  end,
}
