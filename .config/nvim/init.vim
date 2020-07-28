" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/grep.vim'
Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

Plug 'xolox/vim-misc'

Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'lepture/vim-jinja'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'yami-beta/asyncomplete-omni.vim'

Plug 'tpope/vim-abolish'
Plug 'brettanomyces/nvim-editcommand'

Plug 'vim-scripts/dbext.vim'

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('cquery')
   au User lsp_setup call lsp#register_server({
         \ 'name': 'cquery',
         \ 'cmd': {server_info->['cquery']},
         \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery_cache' },
         \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
         \ })
endif

Plug 'FelikZ/ctrlp-py-matcher'
Plug 'majutsushi/tagbar'

"" Color
Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'

" Required:
filetype plugin indent on
call plug#end()

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
  \ 'name': 'omni',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#omni#completor')
  \  }))


" Tagbar
noremap <leader>tt :TagbarToggle<CR>
let g:tagbar_autofocus = 1


" tab complete mappings
let g:asyncomplete_auto_popup = 1
set completeopt+=preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-n>\<cr>" : "\<cr>"

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Encoding
set bomb
set binary


"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set guifont=Monospace\ 10

let no_buffers_menu=1
colorscheme calmar256-light

if &term =~ '256color'
    set t_ut=
endif

"" Disable the blinking cursor.
" set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

set title
set titleold='Terminal'
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
" autocmd VimEnter * NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:nerdtree_tabs_focus_on_files=0
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
let g:NERDTreeHijackNetrw=0
let g:nerdtree_tabs_open_on_gui_startup=0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <leader>ff :NERDTreeFind<CR>
noremap <leader>nn :NERDTreeToggle<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wrapmargin=2
        set textwidth=79
    endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
    nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'


" ale
let g:ale_fixers = {'vim': ['vint'], 'python': ['black'], 'javascript': ['eslint'], 'cpp': ['clang-format'], 'json': ['jq'], 'yaml': ['prettier'], '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_linters = {'vim': ['vint'], 'python': ['pylint'], 'javascript': ['eslint'], 'cpp': ['cpplint', 'cquery', 'clang-check'], 'yaml': ['prettier']}
let g:ale_completion_enabled = 1

noremap <leader>rr :ALEFix<CR>:ALELint<CR>
noremap <leader>F :ALEGoToDefinition<CR>

nmap <silent> <leader>kk <Plug>(ale_previous_wrap)
nmap <silent> <leader>jj <Plug>(ale_next_wrap)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

" Disable visualbell
set visualbell t_vb=

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

"" default delete register is p
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>x "+d
noremap x "px
noremap s "ps
noremap y "py
noremap c "pc
noremap p "pp
noremap dd "pdd
noremap d "pd

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd!<CR>
noremap <leader>C :lclose<bar>b#<bar>bd #<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>


"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" terminal mode escape
tnoremap <Esc> <C-\><C-n>
set wildmode=longest,list,full
set wildmenu
set modifiable

"" Custom configs

" vim-python
augroup vimrc-python
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
        \ formatoptions+=croq softtabstop=4 nosmartindent
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" vim-javascript
augroup vimrc-javascript
    autocmd!
    autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END


"*****************************************************************************
"" Custom configs
"*****************************************************************************

" c
autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType cpp setlocal tabstop=2 shiftwidth=2 expandtab


"" Include user's local vim config
if filereadable(expand('~/.config/nvim/local_init.vim'))
    source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

set clipboard=unnamed
set wildmode=longest,list,full
set wildmenu

noremap <leader>zz :setlocal spell spelllang=en_us<CR>


set number relativenumber


augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
augroup END

" cursor line styling
hi CursorLine gui=underline cterm=underline ctermbg=NONE ctermfg=NONE
hi CursorColumn ctermbg=231 ctermfg=NONE
set cursorline
set cursorcolumn " highlight current column
hi CursorLineNr ctermbg=red

autocmd FileType yaml set ts=2 sts=2 sw=2 expandtab
autocmd FileType yml set ts=2 sts=2 sw=2 expandtab

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

set expandtab

let g:python3_host_prog='/Users/bob/opt/anaconda3'
