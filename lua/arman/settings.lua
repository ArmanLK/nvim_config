-- leader
vim.g.mapleader = ' '
-- time
vim.opt.updatetime = 300
-- inccommand
vim.opt.inccommand = 'split'
-- where to put buffer of the new command
vim.opt.splitbelow = true
-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- lines
vim.opt.scrolloff = 10
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
-- runtime files
vim.opt.swapfile = false
vim.opt.backup = false
-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- termgui colors
vim.opt.termguicolors = true
-- update time (don't know what it does)
vim.opt.updatetime = 50
-- colorcolumn
vim.opt.colorcolumn = '80'

vim.wo.signcolumn = 'yes'

--vim.cmd.syntax 'on'
