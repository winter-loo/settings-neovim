require("plugin_config.mason")
require("plugin_config.colorscheme")
require("plugin_config.lualine")
require("plugin_config.nvim-tree")
require("plugin_config.treesitter")
require("plugin_config.telescope")
require("plugin_config.vim-test")
require("plugin_config.completions")
require("plugin_config.lsp_config")
require("plugin_config.gitsigns")
require("plugin_config.copilot")
require("plugin_config.rust_config")
require("plugin_config.dap_config")
require("nvim-autopairs").setup()
require('leap').add_default_mappings()
require('bufferline').setup{
  options = {
    numbers = 'buffer_id',
  }
}
require('nvim-lastplace').setup{}
