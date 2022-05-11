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
let mapleader = ";"
let maplocalleader = ","
" pathogen ------------------------------------ {{{
execute pathogen#infect()
filetype plugin indent on
" }}}
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
" }}}
" search + grep ------------------------------------ {{{
set hlsearch
nmap <Space> :nohlsearch<cr>
" grep stuff
nnoremap <leader>vg :silent execute "vimgrep /" . expand("<cWORD>") . "/j **/*"<cr>:copen<cr>
nnoremap <F9> :cprevious<cr>
nnoremap <F10> :cnext<cr>
" }}}
" window-related settings ------------------------------------ {{{
nmap <F5> :resize -10<cr>
nmap <F6> :resize +10<cr>
nmap <F7> :vertical resize -10<cr>
nmap <F8> :vertical resize +10<cr>
" }}}
" folding ------------------------------------ {{{
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
" file handling ------------------------------------ {{{
" to open a file in the same directory as the current buffer
cabbr <expr> %% expand('%:p:h')
" }}}
" autocmd ------------------------------------ {{{
autocmd bufnewfile *.pl r ~/.vim/templates/pl
autocmd bufnewfile *.pl 0d
" }}}
" vimrc ------------------------------------ {{{
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
noremap <leader>es :split $MYVIMRC<cr>
noremap <leader>ev :call OpenVimRC()<cr>
noremap <leader>evg :call OpenGVimRC()<cr>
noremap <leader>sv :source $MYVIMRC<cr>
noremap <leader>svg :source $MYGVIMRC<cr>
" }}}
" netrw ------------------------------------ {{{
" TODO what is this?
let g:netrw_liststyle = 3
let g:netrw_winsize = 32
"let g:netrw_browse_split = 4
nnoremap <C-S> :execute "e" expand("%:p:h")<CR>
" }}}
" mappings ------------------------------------ {{{
" -- regular --
nnoremap - ddp
nnoremap _ ddkP
" surround word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <c-w>" <esc>a"<esc>`<i"<esc>
" exit insert mode
inoremap jk <esc>
" -- torture --
inoremap <Left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <Left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
" -- obscure --
" add a semicolon at the end of a line without moving the cursor
nnoremap <leader>bb :<c-u>execute "normal! mqA;\<lt>esc>`q"<cr>
" highlight whitespace on EOL on demand
" NOTE: the highlight "WError" has to be defined in (the custom version of) the colorscheme
"       because all highlight defs will usually be reset there so defining it here wouldn't work
nnoremap <leader>w :match WError /\s\+$/<cr>
nnoremap <leader>W :match<cr>
" {{{ --- toggle stuff ---
" {{{ ------ fold column
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction
" }}}
" {{{ ------ quickfix window
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
" operator: change inside email adress
onoremap in@ :<c-u>execute "normal! /[a-zA-Z0-9._-]\\+@[a-zA-Z0-9._-]\\+\rvE"<cr>
" }}}
" __mappings__ }}}
" abbreviations ------------------------------------ {{{
iabbrev @@ thomas.schmidt_83@gmx.de
iabbrev ssig Thomas Schmidt
iabbrev cinc #include <>
" }}}
" set filetype by extension settings ------------------------------------------------- {{{
augroup filetype_selection
    au BufRead,BufNewFile *.gnu,*.gnuplot set filetype=gnuplot
augroup END
" file-type specific settings ------------------------------------------------- {{{
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
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}
