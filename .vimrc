" ==================
" ===== VUNDLE =====
" ==================
set nocompatible                      " Safer, possibly redundant
filetype off                          " Required by Vundle

set rtp+=~/.vim/bundle/Vundle.vim     " Set up Vundle's runtime path
call vundle#begin()                   " Install plugins with '$ vim +PluginInstall +qall'

Plugin 'VundleVim/Vundle.vim'         " Let Vundle manage itself

" User plugins
Plugin 'scrooloose/nerdtree'          " NERDTree
Plugin 'vim-airline/vim-airline'      " Airline
Plugin 'kien/ctrlp.vim'               "CtrlP
Plugin 'vim-syntastic/syntastic'      " Syntastic
Plugin 'kien/rainbow_parentheses.vim' " RainbowParentheses
Plugin 'bling/vim-bufferline'         " Bufferline
Plugin 'morhetz/gruvbox'              " Gruvbox
Plugin 'xolox/vim-easytags'           " Easytags
Plugin 'xolox/vim-misc'               " Easytags dependency

" End vundle
call vundle#end()
filetype indent plugin on             " Required by Vundle, redundant by the next section

" ==================
" ===== BASICS =====
" ==================

syntax on                             " Syntax highlighting
filetype indent plugin on             " Filetype detection
set tabstop=8                         " Number of spaces that a <Tab> in the file counts for
set expandtab                         " Replace tabs with spaces
set shiftwidth=4                      " Number of spaces to use for each auto indent
set softtabstop=4                     " Number of spaces to expand tabs into
set nu                                " Display line numbers
set ls=2                              " Always show the status line
set background=dark                   " Set this to light or dark depending on your terminal
set noswapfile                        " (optional) Does not create .swp files
set ignorecase                        " Defaults to case insensitive search
set backspace=indent,eol,start        " (optional) Hack to make the backspace button work
set hlsearch                          " Highlights all search results
set pastetoggle=<F2>                  " Toggles paste mode with the F2 key
set mouse=a                           " Enables scrolling with the mouse
" set incsearch                         " Incremental search begins searching as you type

" ==================
" ===== EXTRAS =====
" ==================

" Displays tabs, trailing spaces, etc
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.  " Disable explicit tabs for html/xml

" Deletes all trailing whitespaces (http://vim.wikia.com/wiki/Remove_unwanted_spaces)
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spell checking and line wrapping for git commits
autocmd Filetype gitcommit setlocal spell textwidth=72

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

" NERDTree
let NERDTreeWinPos="right"
let NERDTreeIgnore=['\.pyc$']
command L NERDTreeToggle  " :L toggles NERDTree on and off
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

" Airline
let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 1

"CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
set wildignore+=*.pyc
" Map Ctrl-K to search the buffer
nnoremap <C-K> :CtrlPBuffer<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq =0
let g:syntastic_python_checkers = ['pyflakes', 'pycodestyle']
" let g:syntastic_quiet_messages = { "type": "style" }

" RainbowParentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Bufferline
" This is the default behaviour. This is here as a reminder to install
" bufferline on new systems
let g:airline#extensions#bufferline#enabled = 1

" Gruvbox
let g:gruvbox_contrast_dark = 'hard'
silent colorscheme gruvbox

" Easytags
let g:easytags_auto_highlight = 0
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
set cpoptions+=d
