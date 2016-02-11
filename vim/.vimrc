" Super awesome vim default settings

if has('gui_running')
  set guioptions-=egmrLtT    " no toolbars and stuff
  set guifont=Consolas:h11
endif
  
set bs=2   " normal behavior backspace
syntax on
colorscheme molokai

set ruler      " show cursor position on bottom row
set number     " show line numbers
set nowrap     " don't wrap long lines

" make sure tab = 4 spaces (python)
filetype plugin indent on
set tabstop=4
set softtabstop=4
set expandtab

" set indenting at 2 spaces for sql files
au FileType sql,tpl setl sw=2 ts=2 sts=2 et

set splitbelow          " new splits below original
set splitright          " new splits to the right of original

set cursorline          " highlight line with the cursor
set textwidth=120       " max line width
set colorcolumn=+1      " show where 120 lines end

" set encoding=utf-8
" set fileencoding=utf-8

set wildmenu            " easier browsing through files with vim

set clipboard=unnamed   " always yank to windows clipboard

set autochdir           " automatically set working directory to current file

" Strip trailing whitespace on several filetypes
autocmd FileType py,python,sql,tpl,avsc,java autocmd BufWritePre * :%s/\s\+$//e

au BufReadPost *.tpl set syntax=sql           " treat .tpl files as sql syntax
au BufReadPost *.avsc set syntax=javascript   " treat avro schemas as json syntax


