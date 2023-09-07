local opt = vim.opt
-- leader
vim.g.mapleader = ' '
-- aurora opts
vim.g.aurora_italic = 1
vim.g.aurora_transparent = 1
vim.g.aurora_bold = 1
vim.g.aurora_darker = 1
-- colors
vim.cmd.colorscheme 'aurora'
-- tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
-- lines
opt.scrolloff = 10
opt.number = true
opt.relativenumber = true
opt.wrap = false
-- runtime files
opt.swapfile = false
opt.backup = false
-- searching
opt.hlsearch = false
opt.incsearch = true
-- termgui colors
opt.termguicolors = true
-- update time (don't know what it does)
opt.updatetime = 50
-- colorcolumn
opt.colorcolumn = "80"
-- lua line
require'lualine'.setup{}

vim.cmd[[
    autocmd vimenter * TSContextEnable
    autocmd vimenter * TSEnable highlight
    "autocmd vimenter * hi Normal ctermbg=NONE guibg=NONE
]]
