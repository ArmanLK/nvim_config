-- vim.api.nvim_create_augroup('HighLight', {})

-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
--     group = 'HighLight',
--     command = 'hi Normal ctermbg=NONE guibg=NONE',
-- })

vim.api.nvim_create_augroup('MyTreesitter', {
    clear = false,
})

vim.api.nvim_create_autocmd('BufEnter', {
    group = 'MyTreesitter',
    callback = function()
        vim.cmd 'TSEnable highlight'
        vim.cmd 'TSContextEnable'
    end,
})

vim.api.nvim_create_augroup('TexAucmd', {})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'TexAucmd',
    pattern = '*.tex',
    callback = function()
        vim.api.nvim_create_user_command('PdfLatex', '!pdflatex  \\\\nonstopmode\\\\input %', { bang = true })
    end,
})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'TexAucmd',
    pattern = '*.tex',
    command = 'norm vggG=zz<cr>',
})
