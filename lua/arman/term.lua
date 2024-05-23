local term_group = vim.api.nvim_create_augroup('CostomTermOpen', {})

vim.api.nvim_create_autocmd('TermOpen', {
    group = term_group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

-- exit terminal mode with two <esc>s.
-- TODO: change it to somthing else after using it.
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

-- open a terminal below with a fixed size
vim.keymap.set('n', '<leader>tE', function()
    vim.cmd.new()
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)
