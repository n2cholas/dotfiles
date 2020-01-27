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

set wildmenu
set mouse=a
set noswapfile

let NERDTreeIgnore = ['\.pyc$']
:command NT NERDTree 

" Makes the cursor skinny in insert mode
au InsertEnter * silent execute "!echo -en \<esc>[5 q"
au InsertLeave * silent execute "!echo -en \<esc>[2 q"

if (has("termguicolors"))
  set termguicolors
endif

" Auto Install Plugged
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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

"Below are from Damian Conway's talk: https://youtu.be/aHm36-na4-4

"====[ Make the 81st column stand out ]====================
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)

"=====[ Highlight matches when jumping to next ]=============

    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.4)<cr>
    nnoremap <silent> N   N:call HLNext(0.4)<cr>


    " blink the line containing the match...
    function! HLNext (blinktime)
        set invcursorline
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        set invcursorline
        redraw
    endfunction

"====[ Always turn on syntax highlighting for diffs ]=========================

    " use the filetype mechanism to select automatically...
    filetype on
    augroup PatchDiffHighlight
        autocmd!
        autocmd FileType  diff   syntax enable
    augroup END


