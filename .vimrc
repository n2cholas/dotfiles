autocmd! bufwritepost .vimrc source %

let mapleader = ","

set tabstop=2

set expandtab

set number
set relativenumber

set wildmenu

set splitbelow
set splitright

set hlsearch
set showmatch
set incsearch

set mouse=a
set clipboard=unnamed
set noswapfile

let NERDTreeIgnore = ['\.pyc$']
:command! NT NERDTree 

" Makes the cursor skinny in insert mode
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise

if (has("termguicolors"))
  set termguicolors
endif

" Auto Install Plugged
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install NERDTree (doesn't work with plugged sometimes)
if empty(glob('/.vim/pack/vendor/start/nerdtree/README.markdown'))
   silent !git clone https://github.com/preservim/nerdtree.git 
      \ ~/.vim/pack/vendor/start/nerdtree
   silent !vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
endif

" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'drewtempelmeyer/palenight.vim' " colorscheme
  " Plug 'metakirby5/codi.vim'  " Not great for heavier python
  Plug 'zirrostig/vim-schlepp' " move blocks in visual mode 
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} " fuzzy search
  Plug 'sillybun/vim-repl' " repl while coding in python
call plug#end()

" 81st column and after get highlighted
match Error /\%81v.\+/

set background=dark
colorscheme palenight
syntax on

" For easy switching windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" For schlepp
vmap <up>    <Plug>SchleppUp
vmap <down>  <Plug>SchleppDown
vmap <left>  <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight

" For vim-repl
let g:repl_position = 3
let g:repl_stayatrepl_when_open = 0
let g:repl_cursor_down = 1
nnoremap <leader>r :REPLToggle<Cr>
let g:repl_auto_sends = ['class ', 'def ', 'for ', 'if ', 'while ', 'with ']

