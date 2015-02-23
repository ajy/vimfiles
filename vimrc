" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" =============== Vundle Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use vundle plugin to manage all other plugins

filetype off                    " required!
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle ( required! )
Plugin 'gmarik/vundle'

"Autocompletion bundles
Plugin 'Shougo/neocomplcache.vim'
Plugin 'jiangmiao/auto-pairs'

"file/directory movement bundles
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-eunuch'
if executable("ctags")
  "requires exuberant-ctags
  Bundle 'majutsushi/tagbar'
endif
Plugin 'tpope/vim-projectile'

"handy editing bundles
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'mhinz/vim-startify'
Plugin 'Shougo/unite.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-sleuth'

"Language support bundles
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-git'
Plugin 'jnwhiteh/vim-golang'
Plugin 'derekwyatt/vim-scala'

"misc bundles
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'joonty/vdebug'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mileszs/ack.vim'
Plugin 'Keithbsmiley/investigate.vim'

" Colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'reedes/vim-thematic'

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
set cpoptions+=$                "show $ at the end of the selection when using c
set listchars=tab:▸\ ,eol:¬     "set characters to represent tabs and \n when visible
set scrolloff=3                 "scroll with some context
set sidescrolloff=5
set spelllang=en_gb             "set spell to use british english
set ignorecase                  "ignore case when looking for patterns
set smartcase                   "override ignore case when pattern has upper case
set hlsearch                    "highlight matched patterns
set incsearch                   "search incrementally for pattern
set virtualedit=block           "allow virtual editing in visual mode

"use system clipboard by default for yanking and pasting
set clipboard=unnamed
if has("unix")
  " X system clipboard is different,so
  set clipboard=unnamedplus
endif

"use persistent undo if available
if has('persistent_undo')
  set undofile
endif

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

" I can type :help on my own, thanks.
inoremap <F1> <Esc>
noremap <F1> <Esc>
vnoremap <F1> <Esc>

" Quickly edit the vimrc file in the repo
nmap <silent> <leader>ev :tabe $MYVIMRC<CR>

" ================ Persistent swp/backup ==================
" Keep swaps and backups in one place,
" but avoid the current directory
if isdirectory(expand('~/.cache/vim'))
  set directory^=~/.cache/vim//
  set backupdir^=~/.cache/vim//
  set undodir=~/.cache/vim//
else "never store it in the current directory ever
  if !isdirectory(expand('$HOME/.vim_cache'))
    silent execute '!mkdir '.expand('$HOME/.vim_cache')
  endif
  set backupdir^=$HOME/.vim_cache/
  set directory^=$HOME/.vim_cache/
  set undodir=~/.vim_cache/
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
  augroup FileBasedSettings
    autocmd!
    "Adjust indentation by filetype
    autocmd FileType go setlocal ai ts=8 sw=8 noexpandtab
    "Spellcheck git messages
    autocmd BufRead COMMIT_EDITMSG setlocal spell
  augroup END

  "Auto source vimrc when saved
  augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC,vimrc echo "Reloading vimrc..."
    autocmd BufWritePost $MYVIMRC,vimrc so $MYVIMRC
    autocmd BufWritePost $MYVIMRC,vimrc echo "DONE"
  augroup END

  "Always open help in a new tab
  augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()

    function! HelpInNewTab ()
      if &buftype == 'help'
        execute "normal \<C-W>T"
      endif
    endfunction
  augroup END

  "automatically move to last position in a file
  augroup ReloadPosition
    "automatically jump to the last place you were in a previous session
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
          \| exe "normal! g`\""
          \| endif
  augroup END
endif

" ================ Completion =======================

set wildmenu
set wildmode=longest,full
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.gitkeep,*~ "stuff to ignore when tab completing

" ================ Appearance =======================

"thematic configuration
let g:thematic#defaults = {
      \ 'airline-theme': 'base16',
      \ 'background': 'dark',
      \ 'laststatus': 2,
      \ 'typeface': 'Source Code Pro',
      \ 'font-size': 10,
      \ }

let g:thematic#themes = {
      \   'solarized-dark':{
      \     'colorscheme': 'base16-solarized',
      \     'background': 'dark',
      \   },
      \   'solarized-light':{
      \     'colorscheme': 'base16-solarized',
      \     'background': 'light',
      \   },
      \   'lakeside':{
      \     'colorscheme': 'base16-atelierlakeside',
      \   },
      \   'tomorrow':{
      \     'colorscheme': 'base16-tomorrow',
      \   },
      \   'seaside':{
      \     'colorscheme': 'base16-seaside',
      \   },
      \   'paraiso':{
      \     'colorscheme': 'base16-paraiso',
      \   },
      \ }

let g:thematic#theme_name = 'paraiso'

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
nnoremap <F3> :GundoToggle<CR>

"Yankring
let g:yankring_persist = 0 "don't persist yankring across session
let g:yankring_history_dir = '~/.vim'

" open tagbar window
nmap <F8> :TagbarToggle<CR>


" signify configuration options
let g:signify_vcs_list = [ 'git', 'perforce' ]

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
augroup NeoOmniCompleteSettings
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

" Settings for Unite

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
      \ -buffer-name=files buffer file_rec<CR>

" Quick buffer and mru
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffers buffer<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file_rec file/new<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord -buffer-name=search_file line<CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=commands command<CR>

" create mappings inside unite buffers
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()

  "mappings to leave unite
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <ESC> <Plug>(unite_insert_leave)

  "mappings to move in unite buffers
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)

  imap <buffer> <c-a> <Plug>(unite_choose_action)

  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)

  "mappings to open in split
  inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
let g:unite_split_rule = "botright"

" Shorten the default update date of 500ms
let g:unite_update_time = 200

let g:unite_cursor_line_highlight = 'TabLineSel'

" config for airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

