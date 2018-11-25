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
let g:theme_font="Source\\ Code\\ Pro"
function! SetThemeFont(name)
    let g:theme_font=a:name
endfunction
function! SetFont(size, weight)
    let l:sep = has("gui_win32") ? ":" : "\\ "
    let l:weight = "\\ " . a:weight
    execute "set guifont=" . g:theme_font . l:weight . l:sep . a:size
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
    call SetFont(12, 'Regular')
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
