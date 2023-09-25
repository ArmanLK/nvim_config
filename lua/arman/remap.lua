local set = vim.keymap.set
-- explorer
set('n', '<leader>ep', vim.cmd.Explore)
set('n', '<leader>et', vim.cmd.Texplore)
set('n', '<leader>ev', vim.cmd.Vexplore)
set('n', '<leader>eh', vim.cmd.Hexplore)
-- terminal mode
set('n', '<leader>te', vim.cmd.terminal)
-- buffers
set('n', '<leader>bn', vim.cmd.bnext)
set('n', '<leader>bp', vim.cmd.bprevious)
set('n', '<leader>bd', vim.cmd.bdelete)
-- sourcing
set('n', '<leader>st', '<cmd> source ~/.config/nvim/lua/arman/settings.lua<cr>')
set('n', '<leader>sp', '<cmd> source ~/.config/nvim/lua/arman/lsnip/init.lua<cr>')
set('n', '<leader>sl', '<cmd> source ~/.config/nvim/lua/arman/lsp/init.lua<cr>')
set('n', '<leader>sk', '<cmd> source ~/.config/nvim/lua/arman/remap.lua<cr>')
-- tabs
set('n', '<leader>tn', vim.cmd.tabnext)
set('n', '<leader>tp', vim.cmd.tabprevious)
set('n', '<leader>tl', vim.cmd.tablast)
set('n', '<leader>tf', vim.cmd.tabfirst)
set('n', '<leader>tc', vim.cmd.tabclose)
set('n', '<leader>tN', vim.cmd.tabnew)
-- others
set('n', '<c-d>', '<c-d>zz')
set('n', '<c-u>', '<c-u>zz')
set('i', '<c-c>', '<Esc>')
-- magical keymaps
set('x', '<leader>p', [["_dP]])
set({ 'n', 'v' }, '<leader>y', [["+y]])
set({ 'n', 'v' }, '<leader>d', [["+d]])
set('n', '<leader>Y', [["+Y]])

-- destroying arrow keys (sowy!)
set({ 'n', 'v', 's', 'x', 'i' }, '<Up>', '<Esc>')
set({ 'n', 'v', 's', 'x', 'i' }, '<Down>', '<Esc>')
set({ 'n', 'v', 's', 'x', 'i' }, '<Left>', '<Esc>')
set({ 'n', 'v', 's', 'x', 'i' }, '<Right>', '<Esc>')
