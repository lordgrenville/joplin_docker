setlocal nolist nohls wrap linebreak nocursorline spell spelllang=en_gb noshowmatch iskeyword+=' nocindent
" if text is bigger than window show it, not a few lines of @ @ @
setlocal display=lastline
set mouse=v
set updatetime=300
set signcolumn=yes
set infercase

" move between wrapped lines one at a time (yeah yeah I use the arrow keys...)
nnoremap <buffer> <Up> gk
nnoremap <buffer> <Down> gj
nnoremap <buffer> \s ea<C-X><C-S>
" better spelling suggestion menu

nnoremap <buffer> w W
nnoremap <buffer> W w
nnoremap <buffer> E e
nnoremap <buffer> e E
nnoremap <buffer> b B
nnoremap <buffer> b B
nnoremap j gj
nnoremap k gk

set autoindent " copy indent from previous when starting new line
set autoread " when a file changes outside vim, change it inside vim as well
set autowrite " if a file changes on disk, reload it
set cindent " smart newline autoindenting for languages
set expandtab
set hidden "means hidden buffers are loaded into memory, so no need to save
set nocompatible  " no need for vi compatibility in 2020 AD
set number relativenumber  " current line number + rel for others
set ruler
set t_Co=256
set termguicolors
set shiftwidth=4
set showcmd   "display incomplete commands
set softtabstop=4
set splitbelow  "splits happen opposite to the way vim likes
set splitright
set ttyfast  " supposed to be faster?
set visualbell " enable visual bell in order to disable beeping
set wildmode=longest:full,full
set wildmenu  " visual command line completion
set history=1000  " command line history
set clipboard=unnamedplus " use system clipboard
set laststatus=2 " leave status line on
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set backspace=indent,eol,start
set hlsearch " and to clear the annoying highlighting use :noh or :let @/ = ""
set incsearch " jump to closest instance during search
set ignorecase " case insensitive search
set smartcase " if using a capital, search becomes case sensitive
set scrolloff=3 " number of lines to keep above and below the cursor
" i do this a lot and s is totally useless
nnoremap <silent> s :noh<CR>
" use tab to switch between parentheses!
nnoremap <tab> %
vnoremap <tab> %

syntax enable
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

filetype plugin indent on

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·
set wildmode=list:longest,list:full
" persistent undo even after closing
if has('persistent_undo')
  if !isdirectory($HOME . '/.vim/backups')
    call mkdir($HOME . '/.vim/backups', 'p')
  endif
  set undodir=~/.vim/backups
  set undofile
endif

map Y ^y$
nnoremap gV `[v`]
" explanations at https://dougblack.io/words/a-good-vimrc.html

" pressing n in search  will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" from https://github.com/thoughtbot/dotfiles/blob/master/vimrc
" Leader
let mapleader = " "
nnoremap <Leader><Leader> :FZFMru<CR>
nnoremap <Leader>f [sz=
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

nnoremap <leader>a [s\s

" Buffer commands
noremap <leader>b :bp<CR>
noremap <leader>n :bn<CR>
noremap <leader>k :bd<CR>
nnoremap <F6> <C-^>

" Simplify switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Open help in vertical right tab
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

call plug#begin('~/.vim/plugged')
    Plug 'connorholyday/vim-snazzy'
    " Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tmhedberg/SimpylFold'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'gabenespoli/vim-mutton'
call plug#end()

silent! colorscheme snazzy

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:goyo_enter()
"   setlocal nolist nohls wrap linebreak nocursorline spell spelllang=en_gb noshowmatch iskeyword+=' nocindent tw=70
"   " cindent messes up indentation, tw of window size (80) is too long
" endfunction
function! s:goyo_enter()
  Limelight
endfunction

function! s:goyo_leave()
  Limelight!
  " ...
endfunction

au BufWinLeave * mkview
au BufWinEnter * silent! loadview

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
