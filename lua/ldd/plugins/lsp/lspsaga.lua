return {
  "nvimdev/lspsaga.nvim",
  config = function()
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
