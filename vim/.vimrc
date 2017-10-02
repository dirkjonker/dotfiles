" Super awesome vim default settings
execute pathogen#infect()

if has('gui_running')
  set guioptions-=egmrLtT    " no toolbars and stuff
  set guifont=Consolas:h11
endif
  
" Theme/colors
syntax enable
colorscheme molokai
set number             " show line numbers
set ruler              " show cursor position on bottom row
set cursorline         " highlight the line the cursor is on
set textwidth=150      " max line width
set colorcolumn=+1     " show where 120 lines end
set showmatch          " show matching parentheses

" make sure tab = 4 spaces (python)
filetype plugin indent on
set tabstop=4
set softtabstop=4
set expandtab

" set indenting at 2 spaces for sql files
au FileType sql,tpl setl sw=2 ts=2 sts=2 et

" Vim behavior
set nowrap             " don't wrap long lines by default
set bs=2               " normal behavior backspace
set autochdir          " automatically change working dir
set wildmenu           " for autocomplete on vim command prompt :
set splitright         " open new splits to the right
set splitbelow         " open new splits on the bottom
set ignorecase         " case insensitive search
set incsearch          " start searching before pressing enter

set laststatus=2       " default status menu
set showcmd            " show whatever you are typing in the status bar

set scrolloff=5        " keep at least this much lines above & below cursor
set sidescrolloff=5    " and this much to the sides

set mouse=a            " use mouse

set lazyredraw         " apparently improves speed when using macros


" set encoding=utf-8
" set fileencoding=utf-8

set wildmenu           " easier browsing through files with vim

set clipboard=unnamed  " always yank to windows clipboard


" Strip trailing whitespace on several filetypes
autocmd FileType py,python,sql,tpl,avsc,java autocmd BufWritePre * :%s/\s\+$//e

au BufReadPost *.tpl set syntax=sql           " treat .tpl files as sql syntax
au BufReadPost *.avsc set syntax=javascript   " treat avro schemas as json syntax

cnoreabbrev W w
cnoreabbrev Q q
