set nocompatible
" pathogen
execute pathogen#infect()
filetype plugin indent on

" general settings ------------------------------------ {{{
set autoindent
set backspace=2
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4

set foldmethod=indent
set foldlevelstart=3
set linebreak

set number
syntax on
" }}}

" window-related settings ------------------------------------ {{{
nmap <F5> :resize -10<cr>
nmap <F6> :resize +10<cr>
nmap <F7> :vertical resize -10<cr>
nmap <F8> :vertical resize +10<cr>
nmap <Space> :nohlsearch<cr>
" }}}

" to open a file in the same directory as the current buffer
cabbr <expr> %% expand('%:p:h')

" TODO
" autocmds
autocmd bufnewfile *.pl r h:\101\template_perl.txt
autocmd bufnewfile *.pl 0d

" retain folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

nnoremap <C-S> :execute "e" expand("%:p:h")<CR>
let g:netrw_liststyle = 3
let g:netrw_winsize = 32
"let g:netrw_browse_split = 4
" }}}

" under windows the .vimrc is not located at ~/.vimrc but it will ususally
" contain only a single line which sources the actual .vimrc (which is cloned
" from a git repo)
function! OpenVimRC()
    vsplit $MYVIMRC
    if getline('1') =~ '^so\(urce\)\?'
        normal gg
        normal 0
        normal w
        normal gf
    endif
endfunction
function! OpenGVimRC()
    vsplit $MYGVIMRC
    if getline('1') =~ '^so\(urce\)\?'
        normal gg
        normal 0
        normal w
        normal gf
    endif
endfunction

if filereadable(".vimrc.local")
    source .vimrc.local
endif

" from http://learnvimscriptthehardway.stevelosh.com " {{{
nnoremap - ddp
nnoremap _ ddkP
iabbrev @@ thomas.schmidt@ext.publications.europa.eu
iabbrev ssig Thomas Schmidt, A3 - Test and Integration
iabbrev cinc #include <>
let mapleader = ";"
let maplocalleader = ","
noremap <leader>es :split $MYVIMRC<cr>
noremap <leader>ev :call OpenVimRC()<cr>
noremap <leader>evg :call OpenGVimRC()<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>svg :source $MYGVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <c-w>" <esc>a"<esc>`<i"<esc>
inoremap jk <esc>
inoremap <Left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <Left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
" change inside email adress
onoremap in@ :<c-u>execute "normal! /[a-zA-Z0-9._-]\\+\@[a-zA-Z0-9._-]\\+\r:nohls\rvE"<cr>
" file settings ------------------------------------------------- {{{
augroup filetype_stuff
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType perl nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd filetype c nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^\[=-\]\[=-\]\\+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^\[=-\]\[=-\]\\+$\r:nohlsearch\rg_vk0"<cr>
    autocmd FileType markdown nnoremap <buffer> mh :<c-u>normal! yyp0vg_r=o<cr>
    autocmd FileType markdown nnoremap <buffer> msh :<c-u>normal! yyp0vg_r-o<cr>
augroup END
" }}}
" statuslines ------------------------------------------------- {{{
augroup statuslines
    autocmd!
    autocmd Filetype cpp        setlocal statusline=%f\ %n%=\ %l
    autocmd Filetype markdown   setlocal statusline=%F\ %=\ %l/%L
augroup END
" }}}
" folding ------------------------------------------------- {{{
augroup folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevelstart=3
augroup END
" }}}
" }}}
