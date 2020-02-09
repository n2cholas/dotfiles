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
set ignorecase

set mouse=a
set clipboard=unnamed
set pastetoggle=<F2>

set noswapfile

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

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

" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'drewtempelmeyer/palenight.vim'  " colorscheme
  Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}  " fuzzy search
  Plug 'sillybun/vim-repl'  " repl while coding in python
  Plug 'itchyny/lightline.vim'  " status bar
  Plug 'tpope/vim-fugitive'  " git integration
  Plug 'dense-analysis/ale'  " async linter
  Plug 'maximbaz/lightline-ale'  " display errors
  " Plug 'https://github.com/ycm-core/YouCompleteMe.git'  " intellisense
  Plug 'bling/vim-bufferline'  " buffers in status line
  Plug 'christoomey/vim-tmux-navigator'  " switch windows easily
call plug#end()

" 80st column and after get highlighted
match Error /\%80v.\+/

set background=dark
colorscheme palenight
syntax on

" For easy switching windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" map sort to ,s
vnoremap <leader>s :sort<CR>

" easily move highlighted code blocks
vnoremap < <gv
vnoremap > >gv

" ALE - some of these need to be loaded before ale
let g:ale_sign_warning = '◆'
let g:ale_sign_error = '✗'
nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>
let b:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ }
let g:ale_fix_on_save = 1

" For vim-repl
let g:repl_program = {'python': 'ipython'}
let g:repl_ipython_version = '7.7'

let g:repl_position = 3  " opens to right
let g:repl_stayatrepl_when_open = 0  " doesn't keep cursor at repl
let g:repl_cursor_down =  0 " newline after send to repl
let g:repl_python_automerge = 1  " merges split single lines
let g:repl_console_name = 'REPL'
let g:repl_auto_sends = ['class ', 'def ', 'for ', 'if ', 'while ', 'with ']
let g:repl_input_symbols = {'python': ['>>>', '>>>>', 'ipdb>', 'pdb', '...']}

function! RunCell(jump_option)  " sends code between two '# cell' lines to REPL
  let prev_cell = search('# cell', 'nWbc')
  let next_cell = search('# cell', a:jump_option)
  if (next_cell == 0)
    let next_cell = line('$')
  endif
  call repl#SendLines(prev_cell, next_cell)
endfunction
nnoremap <leader>r :REPLToggle<Cr>
nnoremap <leader>u <Esc>Vgg:SendLineToREPL<Cr>
nnoremap <leader>d <Esc>VG:SendLineToREPL<Cr>
nnoremap <leader>a <Esc>ggVG:SendLineToREPL<Cr>
nnoremap <leader>c :call RunCell('nW')<Cr>
nnoremap <leader>C :call RunCell('W')<Cr>
autocmd Filetype python nnoremap <leader>q <Esc>o%pylab<Esc>:SendCurrentLine<Cr>"_dd
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <leader>n <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <leader>s <Esc>:REPLPDBS<Cr>

inoremap <C-g> <Esc>:SendCurrentLine<Cr>i


" LightLine Stuff
" some from https://github.com/statico/dotfiles/blob/master/.vim/vimrc#L374
" https://github.com/itchyny/lightline.vim/issues/236
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly' ],
      \             [ 'bufferline' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'readonly', 'linter_warnings', 'linter_errors',
      \               'linter_ok' ],
      \              [ 'percent' ] ]
      \ },
      \ 'component': {
      \   'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before}'.
      \                 '%#TabLineSel#%{g:bufferline_status_info.current}'.
      \                 '%#LightLineLeft_active_3#%{g:bufferline_status_info.after}',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK',
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'bufferline': 'info',
      \ },
      \ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction
function! MyBufferLine() abort
  call bufferline#refresh_status()
  let b = g:bufferline_status_info.before
  let c = g:bufferline_status_info.current
  let a = g:bufferline_status_info.after
  return b . c . a
endfunction

autocmd User ALELint call lightline#update() | call lightline#highlight()

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

" BufferLine
let g:bufferline_echo = 0
let g:bufferline_modified = ' +'
let g:bufferline_active_buffer_left = '[ '
let g:bufferline_active_buffer_right = '] '

" netrw stuff
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>
let g:netrw_liststyle = 3  " tree style
let g:netrw_browse_split = 4  " open in right
let g:netrw_altv = 1
let g:netrw_winsize = -28
let g:netrw_banner = 0
let g:netrw_sort_sequence = '[\/]$,*'  " dirs on top, files under

" TMUX Navigator
let g:tmux_navigator_save_on_switch = 2

" Auto close brace
function! ConditionalPairMap(open, close)  " only at end of line
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
inoremap <expr> ( ConditionalPairMap('(', ')')
inoremap <expr> { ConditionalPairMap('{', '}')
inoremap <expr> [ ConditionalPairMap('[', ']')

" Hide command bar
set laststatus=2
set noshowmode
set noshowcmd
set shortmess+=F
