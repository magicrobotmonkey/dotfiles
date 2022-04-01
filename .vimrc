
set nocompatible
call pathogen#infect()
set nowrap
set showmatch
set autoindent
filetype indent on
set wildmode=longest,list
set wildignore+=*.pyc
set textwidth=150
set ignorecase
set smartcase
set incsearch
set gdefault
set ssop=buffers,winsize
set iskeyword+=-,@ " none of these are word dividers
syn on
set hlsearch
set hidden
set cursorline
set cursorcolumn
set scrolloff=3
set sidescrolloff=3
set relativenumber

"detect indent auto switch between tab and space indentation
set tabstop=4
set shiftwidth=4
set expandtab

"highlight bash scripts posix compliant
let g:is_posix = 1

" Save undo/redos
set undofile
set undodir=~/.vimbackup
set directory=~/.vimswp

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"autocmd FileType python setlocal foldmethod=expr
set foldexpr=PythonFoldExpr(v:lnum)
set foldtext=PythonFoldText()

let g:currentDepth = 0
function! PythonFoldExpr(lnum)

	"decrease depth for less indent
    if indent( nextnonblank(a:lnum) )/4 < g:currentDepth
		let g:currentDepth = g:currentDepth - 1
    endif
    
	
	"increase depth for a class or functiion on previous line
    if getline(a:lnum-1) =~ '^\s*\(class\|def\)\s'
		let g:currentDepth = g:currentDepth + 1
    endif
        
	return g:currentDepth

endfunction

function! PythonFoldText()
	let size = 1 + v:foldend - v:foldstart 
	let size = "    \t".size.'    '


	return size.getline(v:foldend)

endfunction

"au BufWrite *.py 1,$s/\s*$//g

syntax enable
set t_Co=16

set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors=16
colorscheme solarized
"hi Search cterm=NONE ctermfg=grey ctermbg=red
highlight  CursorLine ctermbg=0
highlight  CursorColumn ctermbg=0

" hide highlights to start
function! ToggleSolarized()
	if(&background == 'dark')
		set background=light
		highlight  CursorLine ctermbg=7
		highlight  CursorColumn ctermbg=7
	else
		" for light mode
		set background=dark
		highlight  CursorLine ctermbg=0
		highlight  CursorColumn ctermbg=0
	endif
endfunction

":AirlineTheme solarized
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr="║"
let g:airline_symbols.dirty="💩"

" this doesnt work, even though i really want it to
"let g:airline_symbols.modified='🛑'



"swaps
set dir=~/.vimswp

"wtf vim
noremap Y y$



autocmd QuickFixCmdPost *grep* cwindow


"move between splits and windows
noremap <C-h> :bn<CR>
noremap <C-l> :bp<CR>
noremap <C-j> <C-W>w
noremap <C-k> <C-W>W

set backspace=indent,eol,start

"comment and uncomment a line
"map ,c ^i#<ESC>
map ,u ^x

"highligh matching curlies
map ,c Vf{%

noremap <Space> <PageDown>
noremap <BS> <PageUp>
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

noremap <C-w> :lclose<CR>:bp<bar>sp<bar>bn<bar>bd<CR>

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


set formatoptions-=t

" enable code completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" a better htmldjango detection
augroup filetypedetect
  " removes current htmldjango detection located at $VIMRUNTIME/filetype.vim
  au! BufNewFile,BufRead *.html
  au  BufNewFile,BufRead *.html   call FThtml()
 
  func! FThtml()
    let n = 1
    while n < 10 && n < line("$")
      if getline(n) =~ '\<DTD\s\+XHTML\s'
        setf xhtml
        return
      endif
      if getline(n) =~ '{%\|{{\|{#'
        setf htmldjango
        return
      endif
      let n = n + 1
    endwhile
    setf html
  endfunc
augroup END

" close the scratch window from code complete
" when leaving insert mode
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif 


" flake8
" NOTE: using syntastic, need to use syntastic_python_checker_args
let g:flake8_max_line_length=79
" W191: indentation contains tabs
" E121: continuation line indentation is not a multiple of four
" E122: continuation line missing indentation or outdented
" E123: closing bracket does not match indentation of opening bracket's line¬
" E127: continuation line over-indented for visual indent
" E128: continuation line under-indented for visual indent
" E223: tab before operator
" let g:flake8_ignore="W191,E121,E122,E123,E127,E128,E223"

" syntastic (file checking)
let g:syntastic_python_flake8_args=' --max-line-length=79'
let g:syntastic_python_checkers=["flake8"]
"let g:syntastic_python_checker="pyflakes"
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_loc_list_height=8

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python', 'javascript'],
                           \ 'passive_filetypes': ['less', 'css'] }

autocmd BufWritePre *.py execute ':Black'
let g:black_linelength=79


"unite
let g:unite_force_overwrite_statusline = 0
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_prompt = '➤ '
call unite#filters#matcher_default#use(['matcher_glob'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <C-y> :Unite -no-split history/yank<cr>
nnoremap <C-e> :Unite -no-split file_rec<cr>
nnoremap <C-f> :Unite -no-split file<cr>
nnoremap <C-b> :Unite -no-split buffer<cr>

set encoding=utf-8
set laststatus=2

highlight! Folded cterm=NONE ctermfg=magenta
" Enable CursorLine
set cursorline

let g:fugitive_gitlab_domains = ['https://perfecto']
