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
set linebreak

set number
set guioptions=egrLtm
syntax on
" }}}

" general settings ------------------------------------ {{{
function! Dark()
    colorscheme one
    set background=dark
    set guifont=Source\ Code\ Pro\ Medium:h10
    let g:theme_is_set = 1
endfunction
function! Light()
    colorscheme one
    set background=light
    set guifont=Source\ Code\ Pro\ Semibold:h10
    let g:theme_is_set = 1
endfunction
function! Darkbig()
    colorscheme one
    set background=dark
    set guifont=Source\ Code\ Pro:h12
    let g:theme_is_set = 1
endfunction
function! Lightbig()
    colorscheme one
    set background=light
    set guifont=Source\ Code\ Pro\ Medium:h12
    let g:theme_is_set = 1
endfunction
command! Td :call Dark()
command! Tl :call Light()
command! Tdb :call Darkbig()
command! Tlb :call Lightbig()
" these settings are now handled by the functions defined above
"colorscheme tolerable
"set guifont=Courier_Prime_Code:h10:cANSI
if !exists('g:theme_is_set')
    Tl
endif
" }}}

" gui-related settings ------------------------------------ {{{
" initial window size
set lines=40
set columns=120

nmap <F5> :resize -10<cr>
nmap <F6> :resize +10<cr>
nmap <F7> :vertical resize -10<cr>
nmap <F8> :vertical resize +10<cr>
nmap <Space> :nohlsearch<cr>
" }}}

" gui-related settings ------------------------------------ {{{
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
    if line('$') == 1 && getline('.') =~ '^so\(urce\)\?'
        normal 0
        normal w
        normal gf
    endif
endfunction

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
noremap <leader>sv :source $MYVIMRC<cr>
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
    autocmd FileType vim setlocal foldlevelstart=0
augroup END
" }}}
" }}}
