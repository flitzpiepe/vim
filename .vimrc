set nocompatible
behave xterm
"filetype plugin on

" solarized options
" option name               default     optional
" ------------------------------------------------
" g:solarized_termcolors=   16      |   256
" g:solarized_termtrans =   0       |   1
" g:solarized_degrade   =   0       |   1
" g:solarized_bold      =   1       |   0
" g:solarized_underline =   1       |   0
" g:solarized_italic    =   1       |   0
" g:solarized_contrast  =   "normal"|   "high" or "low"
" g:solarized_visibility=   "normal"|   "high" or "low"
" ------------------------------------------------


" bash syntax highlighting error
let g:is_bash = 1

" general
set encoding=utf-8
set ff=unix
set tabstop=4
set shiftwidth=4
set bs=2

" allow project .vimrc files
set exrc

" terminal 256 colors
set t_Co=256

set cc=78,110
set number
set wrap

set ruler

" coolness 
colorscheme koehler
syntax on

"set guifont=Monospace\ 8
set guifont=Monospace\ 8

" folding
set foldmethod=indent
set foldnestmax=10
set foldlevelstart=10
set foldcolumn=2
set foldignore=		" default is #

" pathogen
execute pathogen#infect()

" highlighting
set hlsearch
map <space> :nohlsearch<CR>

" autoindentation
set autoindent
" disabled it because it will always put script comments at the beginning of the line (and won't let me indent them, either)
" set smartindent
set expandtab
set shiftround

" colors by filetype
" autocmd FileType python colorscheme wombat256mod
" autocmd FileType cpp colorscheme wombat256mod
" autocmd FileType perl colorscheme candy
" autocmd FileType ruby colorscheme mustang

" showing whitespaces other than <space>
" activate with		:set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" prevent the resizing of window buffers on window split/close
set noequalalways

" expand '%%' to the path to the file in the current buffer
cabbr <expr> %% expand('%:p:h')

nmap <C-Up> ddkP
nmap <C-Down> ddp

nnoremap <C-o> o<ESC>
nnoremap <C-O> O<ESC>

nnoremap ü <C-]>

if has("autocmd")
	autocmd bufwritepost _vimrc source $MYVIMRC
endif

" print all syntax highlighting groups for the current word under the cursor
function! <SID>SynAttr()
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nmap <C-S-P> :call <SID>SynAttr()<CR>

" prevent accidentally holding shift for too long (e.g. after shift-v, going down one line)
" visual mode
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
" normal mode
nnoremap <S-Up> <Up>
nnoremap <S-Down> <Down>

" list current directory contents
command! LL echo glob('*')
" rot13 file
nmap <F3> ggVGg?
" Show syntax highlighting groups for word under cursor
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" split window stuff
nnoremap <F5> :res -10<CR>
nnoremap <F6> :res +10<CR>
nnoremap <F7> :vertical res -10<CR>
nnoremap <F8> :vertical res +10<CR>


if filereadable(".vimrc.local")
    source .vimrc.local
endif

set secure
