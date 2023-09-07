local builtin = require 'telescope.builtin'
local set = vim.keymap.set

set('n', '<leader>fa', builtin.fd, {})
set('n', '<leader>fb', builtin.buffers, {})
set('n', '<leader>fg', builtin.live_grep, {})
set('n', '<leader>fo', builtin.oldfiles, {})
set('n', '<leader>fr', builtin.registers, {})
set('n', '<leader>fm', builtin.marks, {})
--set('n', '<leader>fj', builtin.jumps, {})
set('n', '<leader>fi', builtin.builtin, {})

