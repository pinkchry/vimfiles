filetype off
call pathogen#runtime_append_all_bundles()

" Sets how many lines of history VIM has to remember
set history=300

" Enable filetype plugin
filetype plugin on
filetype indent on

"set autochdir " always switch to the current file directory

" Set to auto read when a file is changed from the outside
set autoread

set paste "proper formatting of pasted text

"set backup " make backup files
"set backupdir=~/.vim/backup " where to put backup files
"set clipboard+=unnamed " share windows clipboard
"set directory=~/.vim/tmp " directory to place swap files in
set linespace=0 " don't insert any extra pixel lines betweens rows
set lines=50
set columns=160
set laststatus=2

set nonumber
set ai
set tabstop=4
set shiftwidth=4

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
set nobackup
set nowritebackup
set noswapfile

set showtabline=2

set tags=tags;/
set cscopequickfix=s-,g-,c-,d-,i-,t-,e-

set statusline=%F%m%r%h%w\ [fmt=%{&ff}]\ [type=%Y]\ [pos=%l,%v][%p%%]
set guifont=Consolas:h10:cANSI
set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,ex:*/,://

" No sound on errors
set noerrorbells
set novisualbell
set shortmess=atI

syntax enable "Enable syntax hl

if has("gui_running")
  set guioptions-=T
  set background=dark
  set background=dark
  colorscheme biogoo
else
  colorscheme zellner
  set background=dark
endif

"autocmd BufWritePre *.* :%s/$//e

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
 autocmd BufWinEnter quickfix map q :cclose<CR>
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END


" Automatically close preview window when not needed anymore
autocmd InsertLeave * call AutoClosePreviewWindow()
autocmd CursorMovedI * call AutoClosePreviewWindow()

function! AutoClosePreviewWindow()
	if !&l:previewwindow
		pclose
	endif
endfunction


" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <F4> :QFix<CR>
nmap <silent> <F12> <C-]>
nmap <silent> <F7> :call DTEBuildSolution()<CR>
nmap <silent> <C-F7> :call DTECompileFile()<CR>:cclose<CR>
nmap <silent> <F3> :BufExplorer<CR>

map <leader>fr :FufFile **/<CR>
map <leader>ff :FufFile <CR>
map <leader>fb :FufBuffer <CR>
map <leader>fl :FufLine <CR>
"map <leader>fm :FufMruFile <CR>
"map <leader>f: :FufMruCmd <CR>
map <leader>fc :FufChangeList<CR>
map <leader>fj :FufJumpList<CR>
map <leader>fq :FufQuickfix<CR>
map <leader>fF :FufTaggedFile <CR>
map <leader>ft :FufTag <CR>

"Turn off highlighting
nnoremap <esc><esc> :noh<cr>

" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <M-down> <C-W>j
map <M-up> <C-W>k
map <M-left> <ESC>:BB<cr>
map <M-right> <ESC>:BF<cr>
map <C-Up> <ESC>:cp<cr>
map <C-Down> <ESC>:cn<cr> 

map <C-Tab> <ESC>:tabn<cr>
map <C-S-Tab> <ESC>:tabp<cr>

inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <Tab>      pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <leader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

nmap <silent> <Leader>cd :cd %:p:h<CR>
command! CD cd %:p:h
command! LCD lcd %:p:h

nmap <leader>dc :Dox<CR>

"Tips
"Hex editor
"::set binary<CR>:%!xxd<CR>
":%!xxd -r<CR>
"
":perldo $_ = join ' ', reverse split

let OmniCpp_ShowAccess=0
let OmniCpp_ShowPrototypeInAbbr = 1
"let OmniCpp_MayCompleteScope = 0
"let OmniCpp_SelectFirstItem = 1
let OmniCpp_LocalSearchDecl=1
set completeopt=menu,longest

let g:DrChipTopLvlMenu= "&Plugin.&DrChip."

" select last yanked/pasted text
nnoremap gp `[v`]
" redo and go back to beginning of changed text
nmap . .`[

"0x3f8ccccd 0x40066666 0x40466666
function! Float2Hex(arg)
python <<EOL
import vim
import struct
floatval = float(vim.eval("a:arg"))
intval = "0x%02x%02x%02x%02x" %(tuple(reversed(struct.unpack('4B', struct.pack('f', floatval)) )))
vim.command("let l:retval = \"{0}\"".format(intval))
EOL
return l:retval
endfunction

function! Hex2Float(arg)
python <<EOL
import vim
import struct
intval = int(vim.eval("a:arg"), 16)
floatval = struct.unpack('f', struct.pack('i', intval))[0]
vim.command("let l:retval = {0}".format(floatval))
EOL
return l:retval
endfunction

"let g:ackprg= "\"".expand("$VIM") . "\\vimfiles\\bin\\ack -H --nocolor --nogroup --column\""

