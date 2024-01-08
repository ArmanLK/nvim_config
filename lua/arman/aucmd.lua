vim.api.nvim_create_augroup('HighLight', {})

vim.api.nvim_create_augroup('MyTreesitter', {
    clear = false,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    group = 'HighLight',
    command = 'hi Normal ctermbg=NONE guibg=NONE',
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = 'MyTreesitter',
    callback = function()
        vim.cmd 'TSEnable highlight'
        vim.cmd 'TSContextEnable'
    end,
})
