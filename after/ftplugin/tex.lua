vim.api.nvim_create_user_command('PdfLatex', '!pdflatex  \\\\nonstopmode\\\\input %', { bang = true })
vim.api.nvim_create_user_command('LuaLatex', '!lualatex  \\\\nonstopmode\\\\input %', { bang = true })
vim.api.nvim_create_user_command('XeLatex', '!xelatex   \\\\nonstopmode\\\\input %', { bang = true })
