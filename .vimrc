"
" Vim configuration file
"
" Copyright (C) 2018  Thomas Schmidt
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <https://www.gnu.org/licenses/>
"

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
set linebreak
set textwidth=0

"
" folding
"
set foldmethod=indent
set foldlevelstart=10
" from https://stackoverflow.com/a/9407015/5018971
" this lets you jump to the previous/next fold
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

set listchars=eol:$,tab:>-
set number
syntax on
" }}}

" window-related settings ------------------------------------ {{{
nmap <F5> :resize -10<cr>
nmap <F6> :resize +10<cr>
nmap <F7> :vertical resize -10<cr>
nmap <F8> :vertical resize +10<cr>

set hlsearch
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

" TODO review
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
" looks good with colorscheme "one"
highlight WError guibg=#ff5994  
nnoremap <leader>w :match WError /\s\+$/<cr>
nnoremap <leader>W :match<cr>
" grep stuff
nnoremap <leader>vg :silent execute "vimgrep /" . expand("<cWORD>") . "/j **/*"<cr>:copen<cr>
nnoremap <F9> :cprevious<cr>
nnoremap <F10> :cnext<cr>
" add a semicolon at the end of a line without moving the cursor
nnoremap <leader>bb :<c-u>execute "normal! mqA;\<lt>esc>`q"<cr>
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
" grep operator
" {{{
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "vimgrep! " . shellescape(@@) . " **/*"
    copen

    let @@ = saved_unnamed_register
endfunction
" }}}
" {{{ toggle options
" {{{ fold column
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction
" }}}
" {{{ quickfix
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}
" }}}


" {{{ TODO
" when using <leader>ev, the foldmethod is not reinizalied, and
" probably other stuff as well
" }}}
