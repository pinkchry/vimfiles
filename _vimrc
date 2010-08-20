filetype off
call pathogen#runtime_append_all_bundles()

" Sets how many lines of history VIM has to remember
set history=300

" Enable filetype plugin
filetype plugin on
filetype indent on

set autochdir " always switch to the current file directory

" Set to auto read when a file is changed from the outside
set autoread
set switchbuf=usetab

set paste "proper formatting of pasted text

"set backup " make backup files
"set backupdir=~/.vim/backup " where to put backup files
"set clipboard+=unnamed " share windows clipboard
"set directory=~/.vim/tmp " directory to place swap files in
set linespace=0 " don't insert any extra pixel lines betweens rows
set lines=50
set columns=160
set laststatus=2

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 3 lines to the curors - when moving vertical..
set scrolloff=3

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hidden "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set noignorecase "Ignore case when searching
set infercase " case inferred by default

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set matchtime=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

syntax enable "Enable syntax hl

if has("gui_running")
  set guioptions-=T
  set background=dark
  set t_Co=256
  set background=dark
  colorscheme biogoo

  set nu
else
  colorscheme zellner
  set background=dark

  set nonu
endif

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <M-down> <C-W>j
map <M-up> <C-W>k
map <M-left> <ESC>:bp<cr>
map <M-right> <ESC>:bn<cr>

" Use the arrows to something usefull
map <C-Tab> <ESC>:tabn<cr>
map <C-S-Tab> <ESC>:tabp<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

set tags=tags;/

set statusline=%F%m%r%h%w\ [fmt=%{&ff}]\ [type=%Y]\ [pos=%l,%v][%p%%]

"map <leader>ff :FufFile **/<CR>
map <leader>ff :FufFile <CR>
map <leader>ft :FufTag <CR>
map <leader>fb :FufBuffer <CR>
map <leader>fl :FufLine <CR>

set guifont=Consolas:h10:cANSI

set nonumber
set ai
set ts=4
set sw=4

autocmd BufWritePre *.* :%s/$//e

let g:miniBufExplMaxSize=3
let g:miniBufExplorerMoreThanOne=3

" quickfix
let qfix_toggle=12
" toggles the quickfix window.
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen " . g:qfix_toggle
  endif
endfunction

" used to track the quickfix window
augroup QFixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

nmap <silent> <F2> :TMiniBufExplorer<CR>
nmap <silent> <F4> :QFix<CR>

