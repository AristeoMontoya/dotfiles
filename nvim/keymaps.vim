nnoremap <C-a> :e#<CR>
" Cambiar de espacio en el editor
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <A-h> :vertical resize -5<CR>
nnoremap <A-j> :resize -5<CR>
nnoremap <A-k> :resize +5<CR>
nnoremap <A-l> :vertical resize +5<CR>
nnoremap <C-s> :w<CR>
noremap <C-p> :call Fzf_dev()<CR>
tnoremap <ESC> <C-\><C-n><C-p>
nmap Ñ :call AbrirTerminal()<CR>
map <C-f> <Plug>NERDCommenterToggle
hi def VimwikiHeader1 guifg=#61AFEF
hi def VimwikiHeader3 guifg=#E5C07B
hi def VimwikiHeader4 guifg=#E5C07B
hi def VimwikiHeader5 guifg=#E5C07B
hi def VimwikiHeader6 guifg=#E5C07B
hi def VimwikiBold gui=bold guifg=#FFFFFF
hi def VimwikiBoldItalic gui=bold,italic guifg=#FFFFFF
hi def VimwikiCode guifg=#E48AFF
hi link VimwikiPre VimwikiCheckBoxDone
