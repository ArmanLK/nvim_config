-- explorer
vim.keymap.set('n', '<leader>ep', vim.cmd.Explore)
vim.keymap.set('n', '<leader>et', vim.cmd.Texplore)
vim.keymap.set('n', '<leader>ev', vim.cmd.Vexplore)
vim.keymap.set('n', '<leader>eh', vim.cmd.Hexplore)

-- terminal mode
vim.keymap.set('n', '<leader>te', vim.cmd.terminal)

-- buffers
vim.keymap.set('n', '<leader>bn', vim.cmd.bnext)
vim.keymap.set('n', '<leader>bp', vim.cmd.bprevious)
vim.keymap.set('n', '<leader>bd', vim.cmd.bdelete)

-- tabs
vim.keymap.set('n', '<leader>tn', vim.cmd.tabnext)
vim.keymap.set('n', '<leader>tp', vim.cmd.tabprevious)
vim.keymap.set('n', '<leader>tl', vim.cmd.tablast)
vim.keymap.set('n', '<leader>tf', vim.cmd.tabfirst)
vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose)
vim.keymap.set('n', '<leader>tN', vim.cmd.tabnew)

-- splits
vim.keymap.set('n', '<M-,>', '<c-w>5<')
vim.keymap.set('n', '<M-.>', '<c-w>5>')
vim.keymap.set('n', '<M-t>', '<c-w>5+')
vim.keymap.set('n', '<M-s>', '<c-w>5-')

-- some quality of life ones
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('i', '<c-c>', '<Esc>')

-- moving selected lines up or down.
-- TODO: the up doesn't work for multiple lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- copy things (these are amazing)
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- destroying arrow keys (sowy!)
vim.keymap.set({ 'n', 'v', 's', 'x', 'i' }, '<Up>', '<Esc>')
vim.keymap.set({ 'n', 'v', 's', 'x', 'i' }, '<Down>', '<Esc>')
vim.keymap.set({ 'n', 'v', 's', 'x', 'i' }, '<Left>', '<Esc>')
vim.keymap.set({ 'n', 'v', 's', 'x', 'i' }, '<Right>', '<Esc>')
