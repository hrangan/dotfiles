scriptencoding utf-8
" =============================
" ===== Plugin Management =====
" =============================

" Install vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup init
      autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Install custom plugins
call plug#begin('~/.vim/bundles')
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggleVCS'}        " NERDTree
Plug 'kien/ctrlp.vim'                                      " CtrlP fuzzy finder
Plug 'dense-analysis/ale'                                  " Asynchronous lint engine
Plug 'junegunn/rainbow_parentheses.vim'                    " Rainbow parentheses
Plug 'morhetz/gruvbox'                                     " Gruvbox color scheme
Plug 'bling/vim-bufferline'                                " Bufferline support
Plug 'wellle/targets.vim'                                  " More text objects to move to
Plug 'davidhalter/jedi-vim'                                " Autocompletion (disabled) and jump to definition
Plug 'majutsushi/tagbar'                                   " Show tags and a tagbar
Plug 'tpope/vim-surround'                                  " Quoting/parenthesizing made simple
Plug 'tpope/vim-repeat'                                    " Enable repeating supported plugin maps with .
Plug 'tpope/vim-fireplace', {'for': 'clojure'}             " Clojure REPL in vim
" Plug 'dstein64/vim-startuptime'                            " Startup profiling with :StartupTime
call plug#end()

" ==========================
" ===== BASIC SETTINGS =====
" ==========================

syntax on                             " Syntax highlighting
set autoindent                        " Enables indentation for plain text
filetype indent plugin on             " Filetype detection
set tabstop=8                         " Number of spaces that a <Tab> in the file counts for
set expandtab                         " Replace tabs with spaces
set shiftwidth=4                      " Number of spaces to use for each auto indent
set softtabstop=4                     " Number of spaces to expand tabs into
set number                            " Display line numbers
set laststatus=2                      " Always show the status line
set background=dark                   " Set this to light or dark depending on your terminal
set noswapfile                        " (optional) Does not create .swp files
set ignorecase                        " Defaults to case insensitive search
set backspace=indent,eol,start        " (optional) Hack to make the backspace button work
set hlsearch                          " Highlights all search results
set mouse=a                           " Enables scrolling with the mouse
set noincsearch                       " Disable incremental search (on by default in neovim)
set guicursor=a:block-blinkon0        " Hardwires the cursor to a non blinking block
set scrolloff=10                      " Scroll the window when within 10 lines of the edge
set title                             " Change the terminal's title
set hidden                            " Hide buffers when switching instead of closing
set termguicolors                     " Enable true colors support
" set clipboard=unnamed,unnamedplus     " All copied text is added to both PRIMARY and CLIPBOARD

" =========================
" ===== SANITY CHECKS =====
" =========================
if executable('rg')!=1
    echoerr 'Install ripgrep to enable buffer lists in fuzzy searches'
endif

if !(has('python3') || has('python2'))
    echoerr 'jedi-vim needs pynvim installled in python''s site-packages'
endif

" ==========================
" ===== EXTRA SETTINGS =====
" ==========================

" Save undo history
if !isdirectory($HOME.'/.vim')
    call mkdir($HOME.'/.vim', '', 0770)
endif
if !isdirectory($HOME.'/.vim/undo-dir')
    call mkdir($HOME.'/.vim/undo-dir', '', 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Remap <Leader>
let mapleader=';'
let maplocalleader=","

" Move correctly across long, wrapped lines
" nnoremap j gj
" nnoremap k gk

" Capital Y now yanks till the end of the line
noremap Y y$

" Displays tabs, trailing spaces, etc
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
augroup Tabs
    autocmd! filetype html,xml set listchars-=tab:>.  " Disable explicit tabs for html/xml
augroup END

" Deletes all trailing whitespaces (http://vim.wikia.com/wiki/Remove_unwanted_spaces)
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spell checking and line wrapping for git commits
augroup GitSpellCheck
    autocmd! Filetype gitcommit setlocal spell textwidth=72
augroup END

" Remap n/N to always search forwards/backwards respectively
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

" =========================
" ==== PLUGIN SETTINGS ====
" =========================

" ==== NERDTree (scrooloose/nerdtree) ====
let NERDTreeWinPos='left'
let NERDTreeIgnore=['\.pyc$']
let NERDTreeCascadeSingleChildDir=0
nnoremap <Leader>l :NERDTreeToggleVCS<CR>
" Close vim if only NERDTree is open
augroup NERDTreeClose
    autocmd! bufenter *
    \ if (winnr("$") == 1 && exists("b:NERDTree") &&
        \ b:NERDTree.isTabTree()) | q | endif
augroup END

" ==== Fuzzy Finder (kien/ctrlp.vim) ====
let g:ctrlp_user_command = 'rg %s --files'
let g:ctrlp_use_caching = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_map = '<Leader>o'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window ='max:20'
nnoremap <Leader>; :CtrlPBuffer<CR>

" ==== Asynchronous Lint Engine (dense-analysis/ale)====
let g:ale_linters = {'python': ['pycodestyle', 'flake8'],
                   \ 'vimscript': ['vint']}
" Checks errors only in normal mode or when leaving insert mode
" Lint delay can be safely reduced since checking on <CR> is disabled
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 10
" Ctrl-j/k to quickly move between issues in a file
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-o> <Plug>(ale_next_wrap)
" All style errors and warnings are merged into one style
let g:ale_sign_style_error = '--'
let g:ale_set_highlights = 1
augroup ALEColors
    autocmd! ColorScheme * highlight link ALEStyleErrorSign AleWarningSign
augroup END

" ==== Rainbow Parentheses (junegunn/rainbow_parentheses.vim) ====
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup Rainbow
    autocmd! VimEnter * RainbowParentheses
augroup END

" ==== Gruvbox (morhetz/gruvbox) ====
let g:gruvbox_contrast_dark = 'hard'
silent colorscheme gruvbox

" ==== Bufferline (bling/vim-bufferline) ====
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = -1
let g:bufferline_echo = 0

" ==== Vim Jedi ====
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0

" ==== Clojure ====
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1
nnoremap <Leader>e :Eval<CR>

" ==========================
" ==== CUSTOM FUNCTIONS ====
" ==========================

" ==== Statusline ====
" Uses vim-bufferline and tagbar to show a statusbar. Default behaviour is to
" only show the bufferlist, but <Leader>t toggles the tagname at the right
" side of the statusline
nnoremap <Leader>t :call ToggleTagnameInStatus()<CR>
let g:toggle_tagname = 0
function! ToggleTagnameInStatus()
    let g:toggle_tagname = !g:toggle_tagname
endfunction

function! OptionalTagname()
    if g:toggle_tagname
        return tagbar#currenttag('[%s] ','', 'f')
    else
        return ''
    endif
endfunction

augroup Bufferline
  autocmd! VimEnter *
    \ let &statusline= '%{bufferline#refresh_status()}'.bufferline#get_status_string().'%='.'%{OptionalTagname()}'
augroup END

" Create new .py files prefilled with a hash-bang
augroup Templates
    autocmd! BufNewFile *.py execute "normal i#!/usr/bin/env python\r\r\<Esc>"
augroup END
