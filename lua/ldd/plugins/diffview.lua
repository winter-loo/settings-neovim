return {
  "sindrets/diffview.nvim",
  config = function()
    require('diffview').setup({
      view = {
        default = {
          -- ┌──────────────┐
          -- │      A       │
          -- │              │
          -- ├──────────────┤
          -- │      B       │
          -- │              │
          -- └──────────────┘
          layout = "diff2_vertical"
        }
      }
    })
  end
}
