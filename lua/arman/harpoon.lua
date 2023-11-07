local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'
-- local term = require 'harpoon.term'
-- local tmux = require 'harpoon.tmux'
-- local cmd_ui = require 'harpoon.cmd-ui'

require('telescope').load_extension 'harpoon'

vim.keymap.set('n', '<leader>ha', mark.add_file)
vim.keymap.set('n', '<leader>he', ui.toggle_quick_menu)
vim.keymap.set('n', '<leader>hz', function()
    ui.nav_file(1)
end)
vim.keymap.set('n', '<leader>hx', function()
    ui.nav_file(2)
end)
vim.keymap.set('n', '<leader>hc', function()
    ui.nav_file(3)
end)
vim.keymap.set('n', '<leader>hv', function()
    ui.nav_file(4)
end)
