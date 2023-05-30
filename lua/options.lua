vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.tmux_navigator_save_on_switch = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

-- paste from system clipboard
-- harms startup speed !!!
-- vim.opt.clipboard:append("unnamedplus")

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set 'noexpandtab' for Makefiles
vim.api.nvim_exec([[
  autocmd FileType make set noexpandtab
]], false)
