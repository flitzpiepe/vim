"colorscheme onedark
colorscheme hemisu
set background=light
set guifont=Source\ Code\ Pro\ 10
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

function Dark()
	colorscheme one
	set background=dark
endfunction
function Light()
	colorscheme one
	set background=light
endfunction
command Td :call Dark()
command Tl :call Light()
Td
