set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8
set number relativenumber
set nowrap
set cc=80
" removes not needed spaces for writing
autocmd BufwritePre * %s/\s\+$//e
