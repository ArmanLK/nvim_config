vim.api.nvim_create_augroup('HighLight', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    group = 'HighLight',
    command = 'hi Normal ctermbg=NONE guibg=NONE',
})
