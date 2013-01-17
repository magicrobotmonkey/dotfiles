call pathogen#infect()
set nowrap
set showmatch
set autoindent
set wildmode=longest,list
set textwidth=150
set ignorecase
set smartcase
set incsearch
set gdefault
set ssop=buffers,winsize
set iskeyword+=-,@ " none of these are word dividers
set tabstop=4
set shiftwidth=4
set noexpandtab
syn on
set hlsearch
set hidden
set cursorline
set cursorcolumn
set nohlsearch
set scrolloff=3
set sidescrolloff=3

autocmd FileType yaml setlocal expandtab 

syntax enable
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized
"hi Search cterm=NONE ctermfg=grey ctermbg=red

"swaps
set dir=~/.vimswp

"this one selects a function starting including its header if its properly
"formatted. run it from anywhere in the fxn but the starting /**
"noremap ,f ?/\*\*<CR>V%/function<CR>/{<CR>%
" and this folds a function into two folds, header and inner
"noremap ,d ?/\*\*<CR>zf%/{<CR>zf%

"wtf vim
noremap Y y$

"move between splits and windows
noremap <C-h> :bn<CR>
noremap <C-l> :bp<CR>
noremap <C-j> <C-W>w
noremap <C-k> <C-W>W

set backspace=indent,eol,start

"comment and uncomment a line
map ,c ^i#<ESC>
map ,u ^x

noremap <Space> <PageDown>
noremap <BS> <PageUp>
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" Delete the current buffer, issuing bnext in all windows
" where displayed before that
function DeleteBuffer2()
  let bid = bufnr("%")
  let wid = winnr()
  windo if bid == bufnr("%") | bprev | endif
  exe "bdel " . bid
  exe "normal " . wid . "^W^W"
endfunction

" count the number of buffers
function BufferCount()
  " save cur buf number
  let cbuf = bufnr("%")
  let bnum = 0
  bufdo let bnum = bnum + 1
  " return to the buf
  exe "b " . cbuf
  return bnum
endfunction

function DeleteBuffer()
  if BufferCount() > 1
    call DeleteBuffer2()
  else
    exe "bdel"
  endif
endfunction

map <C-W> :call DeleteBuffer()<CR>
imap <C-W> <C-O><C-W>


set formatoptions-=t

" enable code completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" close the scratch window from code complete
" when leaving insert mode
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 


" flake8
" NOTE: using syntastic, need to use syntastic_python_checker_args
let g:flake8_max_line_length=150
" W191: indentation contains tabs
" E121: continuation line indentation is not a multiple of four
" E122: continuation line missing indentation or outdented
" E123: closing bracket does not match indentation of opening bracket's line¬
" E127: continuation line over-indented for visual indent
" E128: continuation line under-indented for visual indent
" E223: tab before operator
let g:flake8_ignore="W191,E121,E122,E123,E127,E128,E223"

" syntastic (file checking)
let g:syntastic_python_checker_args='--ignore=W191,E121,E122,E123,E127,E128,E223 --max-line-length=150'
let g:syntastic_python_checker="flake8"
"let g:syntastic_python_checker="pyflakes"
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_loc_list_height=8

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python', 'javascript'],
                           \ 'passive_filetypes': ['less', 'css'] }


" powerline
set encoding=utf-8
set nocompatible
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'
" let g:Powerline_theme='short'
let g:Powerline_colorscheme='solarized16'

"python from powerline.ext.vim import source_plugin; source_plugin()
"source ~/.local/lib/python2.7/site-packages/powerline/ext/vim/source_plugin.vim
