" Usar Markdown para VimWiki
let g:vimwiki_list = [{'path': '~/notas/', 'syntax': 'markdown', 'ext': '.md'}]
let wiki = { }
let wiki.path = '~/notas/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'js': 'javascript',
			\ 'java': 'java', 'sql': 'sql', 'css': 'css', 'html': 'html', 'hskl': 'haskell',
			\ 'arduino': 'arduino', 'php': 'php', 'json': 'json', 'sh': 'sh'
			\}

let g:vimwiki_diary_months = {
			\ 1: 'Enero', 2: 'Febrero', 3: 'Marzo',
			\ 4: 'Abril', 5: 'Mayo', 6: 'Junio',
			\ 7: 'Julio', 8: 'Agosto', 9: 'Septiembre',
			\ 10: 'Octubre', 11: 'Noviembre', 12: 'Diciembre'
			\ }

let g:taskwiki_markup_syntax = 'markdown'
let g:taskwiki_disable_concealcursor = 'yes'
let g:markdown_folding = 1

" Definiciones de grupos de VimWiki
hi def VimwikiHeader1 guifg = #61AFEF
hi def VimwikiHeader2 guifg = #98C379
hi def VimwikiHeader3 guifg = #E5C07B
hi def VimwikiHeader4 guifg = #E5C07B
hi def VimwikiHeader5 guifg = #E5C07B
hi def VimwikiHeader6 guifg = #E5C07B
hi def VimwikiBold gui = bold guifg = #FFFFFF
hi def VimwikiBoldItalic gui = bold,italic guifg = #FFFFFF
hi def VimwikiCode guifg = #E48AFF
hi link VimwikiPre VimwikiCheckBoxDone
