" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" =============== Vundle Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use vundle plugin to manage all other plugins

filetype off                    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle ( required! ) 
Bundle 'gmarik/vundle'

"Autocompletion bundles
Bundle 'Raimondi/delimitMate'
Bundle 'Shougo/neocomplcache.vim'

"file/directory movement bundles
Bundle 'Lokaltog/vim-easymotion.git'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-eunuch'
if executable("ctags")
  "requires exuberant-ctags
  Bundle 'majutsushi/tagbar'
endif

"handy editing bundles
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-abolish'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'sjl/clam.vim'
Bundle 'mhinz/vim-startify'

"Language support bundles
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-git'

"misc bundles
Bundle 'Lokaltog/vim-powerline'
" Bundle 'maciakl/vim-neatstatus'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

" Colorschemes
Bundle 'nanotech/jellybeans.vim'

" ================ General Config ====================

set t_Co=256                    "Always use all 256 colors
set number                      "Line numbers are good
set hidden                      "It's okay to have buffers that are hidden
set showcmd                     "show partially written commands (in the bottom-right corner)
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=10000               "Store lots of :cmdline history
set gcr=a:blinkon0              "Disable cursor blink, does not work in terminal
set visualbell                  "No sounds
set t_vb=                       "No flashes
set autoread                    "Reload files changed outside vim
set cursorline                  "highlight the current line always
set ruler                       "get a handy ruler in the corner
set encoding=utf-8              "Necessary to show unicode glyphs for powerline
set fileformats=unix,mac,dos    "get all the file formats, set to particular one using :set fileformat= command
set showmatch                   "show matching bracket always
set mouse=a                     "set mouse mode to all, so i can use it
set laststatus=2                "always show the status line, required with powerline
set nofoldenable                "Say no to code folding...
set cpoptions+=$                "show $ at the end of the selection when using c,has to be here otherwise it gets reset
set listchars=tab:▸\ ,eol:¬     "set characters to represent tabs and \n when visible
set scrolloff=3                 "scroll with some context
set sidescrolloff=5
set spelllang=en_gb             "set spell to use british english
set ignorecase                  "ignore case when looking for patterns
set smartcase                   "overide ignore case when pattern has upper case
set hlsearch                    "highlight matched patterns
set incsearch                   "search incrementally for pattern
syntax on

" ================ remapped keys =====================

" remap leader key
let mapleader = ","

" shows invisibles in normal mode
nmap <leader>l :set list!<CR>

"logical movement
noremap j gj
noremap k gk

" toggle spell check
nmap <leader>s :set spell!<CR>

"never press shift to enter commands again
nmap ; :

" remove highlighting
nmap <leader>rh :noh<CR>

" a more logical Y in normal mode
nnoremap Y y$

" Quickly edit/reload the vimrc file in the repo
nmap <silent> <leader>ev :tabe ~/.vim/vimrc<CR>
nmap <silent> <leader>sv :echo "Reloading vimrc..."<CR>:so $MYVIMRC<CR>:echo "Reloading vimrc...DONE"<CR>

"key mappings to copy paste using system clipboard
map <leader>y "+y
map <leader>p "+p

" ================ Persistent swp/backup ==================
" Keep swaps and backups in one place,
" but avoid the current directory

if isdirectory(expand('~/.cache/vim'))
    set directory^=~/.cache/vim//
    set backupdir^=~/.cache/vim//
else "never store it in the current directory ever
    set backupdir-=.
    set directory-=.
endif

" ================ Indentation ======================

" default settings
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround "round off indent to multiple of shiftwidth, untested

filetype plugin indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points, without inserting <EOL>s

if has('autocmd')
    "Adjust indentation by filetype
    autocmd FileType go setlocal ai ts=8 sw=8 noexpandtab
endif

" ================ Completion =======================

set wildmenu
set wildmode=longest,full
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.gitkeep,*~ "stuff to ignore when tab completing

" ================ Appearance =======================

try
  "get custom colorscheme
  colorscheme jellybeans
catch "if you can't, use this scheme
  colorscheme slate
endtry

if has("gui_running")
  set gfn=Monaco\ for\ Powerline\ 11
  let g:Powerline_symbols = 'fancy'
else
  let g:Powerline_symbols = 'compatible'
endif


" ================ Plugin customisation =============

"syntastic
let g:syntastic_error_symbol='✗' "change the default error symbol

"NERDTree
let NERDTreeIgnore = ['\.pyc$'] "ignore files in file browser
" open NERDTree window
nnoremap <F4> :NERDTreeToggle<CR>

"Gundo
let g:gundo_preview_bottom = 1 "improve how gundo window is displayed
" open gundo window
nnoremap <F5> :GundoToggle<CR>

"Yankring
let g:yankring_persist = 0 "don't persist yankring across session
let g:yankring_history_dir = '~/.vim'

" open tagbar window
nmap <F8> :TagbarToggle<CR>

"open ctrlp window, fixes conflict between yankring mappings
let g:ctrlp_map = '<leader>f'
nnoremap <leader>b :CtrlPBuffer<CR>

" clam bindings
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Options for neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'"
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
      "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
