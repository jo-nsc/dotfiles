
" =========================
" Minimal IDE + OSC52 yank
" (VSCode-ish + lightweight)
" =========================

set nocompatible
filetype plugin indent on
syntax on

" --- UI / comfort ---
set number
set relativenumber
set showcmd
set wildmenu
set lazyredraw
set ttyfast
set scrolloff=5
set signcolumn=yes
set nocursorline      " you said you don't want line highlight

" --- editing ---
set tabstop=4 shiftwidth=4 expandtab
set smartindent
set hidden
set backspace=indent,eol,start
set incsearch hlsearch ignorecase smartcase
set undofile
set synmaxcol=240     " faster highlighting on long lines
set laststatus=2
set statusline=%f\ %m%r%h%w\ [%{&filetype}]\ %=%l:%c\ %p%%

" --- cursor shapes by mode (terminal-safe) ---
if &term =~# 'xterm\|tmux\|screen\|linux'
  let &t_EI = "\<Esc>[2 q"
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
endif

" --- plugins ---
call plug#begin('~/.vim/plugged')
Plug 'ojroques/vim-oscyank'
Plug 'joshdick/onedark.vim'
call plug#end()

" --- colors (VSCode-ish dark) ---
set termguicolors
set background=dark
colorscheme onedark

" --- OSC52 with ST terminator (needed for your Windows Terminal) ---
let g:oscyank_osc52 = "\x1b]52;c;%s\x1b\\"

" Auto-copy ANY yank to local clipboard via OSC52-ST
augroup OSCYank
  autocmd!
  autocmd TextYankPost *
        \ if v:event.operator is# 'y' |
        \   silent! call OSCYank(join(v:event.regcontents, "\n")) |
        \ endif
augroup END

" Optional: if server Vim ever has clipboard, use it too
if has('clipboard')
  set clipboard=unnamedplus
endif
