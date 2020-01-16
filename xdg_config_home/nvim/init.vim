"#########################
" Plugins using vim-plug "
"#########################

let g:ale_completion_enabled = 1

" fuzzy finder - use fd to respect .gitignore
let $FZF_DEFAULT_COMMAND = 'fd --type f'

call plug#begin()

" auto closes parens
Plug 'cohama/lexima.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'

" awesome paren/quote/etc handling
Plug 'tpope/vim-surround'
" make sure you can use . to repeat surround cmds
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'

" lisp
Plug 'bhurlow/vim-parinfer'

" fuzzy finder
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

" linter handler
Plug 'dense-analysis/ale'

" " language server
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" " autocompletion
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" " rust completion
" " Plug 'ncm2/ncm2-racer'

" language specific
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'leafgarland/typescript-vim'
" Plug 'hashivim/vim-terraform'

" nginx config
" Plug 'chr4/nginx.vim'

" css stuff
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ap/vim-css-color'

" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Ruby
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'

" JS
Plug 'othree/yajs.vim'

" Jinja templates
Plug 'Glench/Vim-Jinja2-Syntax'

" themes
Plug 'Jimeno0/vim-chito'
Plug 'ajmwagar/vim-deus'
Plug 'icymind/NeoSolarized'
Plug 'kaicataldo/material.vim'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'phanviet/vim-monokai-pro'
Plug 'skreek/skeletor.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'morhetz/gruvbox'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" line numbers
set number

" auto reload changed files
set autoread

"##############
" Colorscheme "
"##############
" proper terminal color support
set termguicolors

set background=dark
colorscheme chito
let g:airline_theme='snow_dark'

" use uppercase write/quit
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev wQ wq
cnoreabbrev Wq wq

" set case-sensitivity like ag -> case-insensitive for lowercase,
" case-sensitive if search string contains an uppercase letter
set ignorecase
set smartcase

nnoremap <leader><space> :noh<CR>
nnoremap <leader>t :tabnew<space>
nnoremap <leader>q :q<CR>
nnoremap <leader>m :set nowrap<CR>
nnoremap <leader>n :set wrap<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>g :Rg<CR>

" tab navigation with Alt + h and Alt + l
nnoremap <A-h> :tabprevious<CR>
nnoremap <A-l> :tabnext<CR>
nnoremap <A-Left> :tabm -1<CR>
nnoremap <A-Right> :tabm +1<CR>
nnoremap <A-S-h> :tabm -1<CR>
nnoremap <A-S-l> :tabm +1<CR>

" file types
augroup filetypedetect
    au BufRead,BufNewFile *.jbuilder set filetype=ruby
augroup END

" do not complete def/end if/end etc. in ruby etc.
let g:lexima_enable_endwise_rules = 0

" rust folding
let g:rust_fold = 1

" strip whitespace on save
let g:ale_fixers = {
    \  'css': ['prettier'],
    \  'groovy': ['remove_trailing_lines', 'trim_whitespace'],
    \  'javascript': ['prettier'],
    \  'json': ['jq'],
    \  'markdown': ['remove_trailing_lines', 'trim_whitespace'],
    \  'ruby': ['rubocop'],
    \  'rust': ['rustfmt'],
    \  'scss': ['remove_trailing_lines', 'trim_whitespace'],
    \  'slim': ['remove_trailing_lines', 'trim_whitespace'],
    \  'terraform': ['terraform', 'trim_whitespace', 'remove_trailing_lines'],
    \  'tf': ['terraform'],
    \  'typescript': ['prettier'],
    \  'yaml': ['remove_trailing_lines', 'trim_whitespace'],
    \}
    "\  'python': ['black'],
    "\  'yaml': ['prettier'],
let g:ale_javascript_prettier_executable = 'prettier'
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_linters = {
    \ 'html': [],
    \ 'python': ['flake8'],
    \ 'rust': ['rls'],
    \}

let g:ale_fix_on_save = 1
" let g:ale_set_balloons = 1
" let g:ale_hover_to_preview = 1

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gD :ALEGoToDefinition<CR>
nnoremap <silent> gd :ALEGoToDefinitionInTab<CR>

" " Language server
" set hidden
"
" " enable autocomplete for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect
"
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ }
"
" nnoremap <silent> gC :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <buffer> <silent> gd <C-w>v:call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gD :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" mouse on iTerm
set mouse=a
