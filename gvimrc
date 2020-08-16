"
" Vim configuration file - the GUI part
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

set guioptions=aegirLt

set lines=40
set columns=140
winpos 350 100

" the sourcing of .vimrc.local is duplicated here because .gvimrc is loaded after .vimrc and might overwrite
" the settings of .vimrc.local again...
if filereadable(".vimrc.local")
    source .vimrc.local
endif
if filereadable(".gvimrc.local")
    source .gvimrc.local
endif

" theme-related settings ------------------------------------ {{{
let g:theme_font = has("gui_win32") ? "Source_Code_Pro" : "Source\\ Code\\ Pro"
function! SetThemeFont(name)
    let g:theme_font=a:name
endfunction
function! SetFont(size, weight)
    let l:sep_size = has("gui_win32") ? ":" : "\\ "
    let l:sep_word = has("gui_win32") ? "_" : "\\ "
    let l:size = has("gui_win32") ? "h".a:size : a:size
    let l:weight = a:weight != "" ? l:sep_word . a:weight : ""
    execute "set guifont=" . g:theme_font . l:weight . l:sep_size . l:size
endfunction
function! Dark()
    colorscheme one
    set background=dark
    call SetFont(10, 'Medium')
    let g:theme_is_set = 1
endfunction
function! Light()
    colorscheme one
    set background=light
    call SetFont(10, 'Medium')
    let g:theme_is_set = 1
endfunction
function! Darkbig()
    colorscheme one
    set background=dark
    call SetFont(12, '')
    let g:theme_is_set = 1
endfunction
function! Lightbig()
    colorscheme one
    set background=light
    call SetFont(12, 'Medium')
    let g:theme_is_set = 1
endfunction
command! Td :call Dark()
command! Tl :call Light()
command! Tdb :call Darkbig()
command! Tlb :call Lightbig()
if !exists('g:theme_is_set')
    Tl
endif
" }}}
