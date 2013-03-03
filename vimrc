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
Bundle 'kana/vim-smartinput'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-ragtag'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'

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

"Language support bundles
Bundle 'tpope/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-git'

"misc bundles
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

" Colorschemes
Bundle 'nanotech/jellybeans.vim'
Bundle 'altercation/vim-colors-solarized'

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
  colorscheme solarized
  set background=dark
  call togglebg#map("<F6>")
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

let g:SuperTabDefaultCompletionType = 'context' "use context to complete by default

let g:snips_trigger_key='<c-space>' "changed snipmate trigger key

" open tagbar window
nmap <F8> :TagbarToggle<CR>

"open ctrlp window, fixes conflict between yankring mappings
let g:ctrlp_map = '<leader>f'
nnoremap <leader>b :CtrlPBuffer<CR>

" clam bindings
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" trying to get sensible completion to work, using supertab
autocmd FileType *
            \ if &omnifunc != '' |
            \   call SuperTabChain(&omnifunc, "<c-p>") |
            \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
            \ endif
