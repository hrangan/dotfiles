" ==================
" ===== VUNDLE =====
" ==================
filetype off                          " Required by Vundle

set rtp+=~/.vim/bundle/Vundle.vim     " Set up Vundle's runtime path
call vundle#begin()                   " Install plugins with '$ vim +PluginInstall +qall'

Plugin 'VundleVim/Vundle.vim'         " Let Vundle manage itself

" User plugins
Plugin 'scrooloose/nerdtree'          " NERDTree
" Plugin 'vim-airline/vim-airline'      " Airline
Plugin 'junegunn/fzf'                 " Command line fuzzy finder (requires Ag)
Plugin 'junegunn/fzf.vim'             " fzf.vim wrapper for fzf
Plugin 'dense-analysis/ale'           " Asynchronous Lint Engine
Plugin 'kien/rainbow_parentheses.vim' " RainbowParentheses
Plugin 'morhetz/gruvbox'              " Gruvbox
Plugin 'xolox/vim-easytags'           " Easytags, requires `apt install exuberant-ctags`
Plugin 'xolox/vim-misc'               " Easytags dependency
Plugin 'bling/vim-bufferline'         " Bufferline

" End vundle
call vundle#end()
filetype indent plugin on             " Required by Vundle, redundant by the next section

" ==================
" ===== BASICS =====
" ==================

syntax on                             " Syntax highlighting
set autoindent                        " Enables indentation for plain text
filetype indent plugin on             " Filetype detection
set tabstop=8                         " Number of spaces that a <Tab> in the file counts for
set expandtab                         " Replace tabs with spaces
set shiftwidth=4                      " Number of spaces to use for each auto indent
set softtabstop=4                     " Number of spaces to expand tabs into
set number                            " Display line numbers
set ls=2                              " Always show the status line
set background=dark                   " Set this to light or dark depending on your terminal
set noswapfile                        " (optional) Does not create .swp files
set ignorecase                        " Defaults to case insensitive search
set backspace=indent,eol,start        " (optional) Hack to make the backspace button work
set hlsearch                          " Highlights all search results
set pastetoggle=<F2>                  " Toggles paste mode with the F2 key
set mouse=a                           " Enables scrolling with the mouse
set clipboard=unnamed,unnamedplus     " All copied text is added to both PRIMARY and CLIPBOARD

" ==================
" ===== EXTRAS =====
" ==================

" Remap <Leader>
let mapleader=";"

" Displays tabs, trailing spaces, etc
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd! filetype html,xml set listchars-=tab:>.  " Disable explicit tabs for html/xml

" Deletes all trailing whitespaces (http://vim.wikia.com/wiki/Remove_unwanted_spaces)
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spell checking and line wrapping for git commits
autocmd! Filetype gitcommit setlocal spell textwidth=72

" Map Ctrl+Arrow key to work movement
map <ESC>Oa <C-Up>
map <ESC>Ob <C-Down>
map <ESC>Od <C-Left>
map <ESC>Oc <C-Right>

" Map Ctrl+Arrow key to work movement in insert mode
map! <ESC>Oa <C-Up>
map! <ESC>Ob <C-Down>
map! <ESC>Od <C-Left>
map! <ESC>Oc <C-Right>

" n always searches forward, N backwards
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" ==================
" ==== PLUGINS  ====
" ==================

" ==== NERDTree (scrooloose/nerdtree) ====
let NERDTreeWinPos="right"
let NERDTreeIgnore=['\.pyc$']
nnoremap <Leader>l :NERDTreeToggle<CR>
" Disable arrow icons
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '~'
"
" Close vim if only NERDTree is open
" autocmd! \
"   bufenter * if (winnr("$") == 1 && exists("b:NERDTree") \
"      && b:NERDTree.isTabTree()) | q | endif

" ==== Airline (vim-airline/vim-airline) ====
" let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 1

" ==== Fuzzy Finder (junegunn/fzf.vim) ====
" Replaces fzf command with ag. This ensures .gitignore is respected
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <Leader>; :Buffers<CR>
nnoremap <Leader>o :Files<CR>

" ==== Asynchronous Lint Engine (dense-analysis/ale)====
let g:ale_linters = {'python': ['pycodestyle', 'flake8']}
" Checks errors only in normal mode or when leaving insert mode
" Lint delay can be safely reduced since checking on <CR> is disabled
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 10
" Ctrl-j/k to quickly move between issues in a file
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" All style errors and warnings are merged into one style
let g:ale_sign_style_error = '--'
let g:ale_set_highlights = 1
augroup ALEColors
    " Rationale for highlight augroup
    " https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
    autocmd!
    autocmd ColorScheme * highlight link ALEStyleErrorSign AleWarningSign
augroup END

" ==== Rainbow Parentheses (kien/rainbow_parentheses.vim) ====
augroup Rainbow
    autocmd!
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
augroup END

" ==== Gruvbox (morhetz/gruvbox) ====
let g:gruvbox_contrast_dark = 'hard'
silent colorscheme gruvbox

" ==== Easytags (xolox/vim-easytags) ====
let g:easytags_auto_highlight = 0
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
set cpoptions+=d

" ==== Bufferline (bling/vim-bufferline) ====
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = 0
let g:bufferline_echo = 0
" statusline integration if vim-airline is disabled
autocmd! VimEnter *
\ let &statusline='%{bufferline#refresh_status()}'
  \ .bufferline#get_status_string()
