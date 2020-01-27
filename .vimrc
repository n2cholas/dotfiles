set tabstop=2
set expandtab
set number
set relativenumber
set wildmenu
set splitbelow
set splitright
set mouse=a
set showmatch
set incsearch
set noswapfile

let NERDTreeIgnore = ['\.pyc$']
:command NT NERDTree 

" Makes the cursor skinny in insert mode
au InsertEnter * silent execute "!echo -en \<esc>[5 q"
au InsertLeave * silent execute "!echo -en \<esc>[2 q"

if (has("termguicolors"))
  set termguicolors
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'metakirby5/codi.vim'
Plug 'zirrostig/vim-schlepp'
Plug 'junegunn/fzf' ", {'dir': '~/.fzf', 'do': './install --all'}
call plug#end()

set background=dark
colorscheme palenight
syntax on

" For easy switching windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" For schlepp
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight


