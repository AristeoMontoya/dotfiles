" Mantener el tamaño de los splits al cambiar el tamaño de ventana
autocmd VimResized * wincmd =

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
