call which_key#register('<Space>', "g:which_key_map")

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map =  {}

let g:which_key_map.g = {
			\ 'name' : '+Git',
			\ 's' : [':G'			,	 'Git Status'],
			\}

let g:which_key_map.s = {
			\ 'name' : '+Splits',
			\ 'h' : ['split'	,		 'Split horizontal'],
			\ 's' : ['<C-W>R'	,					'Rotar'],
			\ 't' : ['<C-W>T'	,	'Mover split a pestaña'],
			\ 'v' : ['vs'		,		   'Split vertical'],
			\}


let g:which_key_map.t = {
			\ 'name' : '+Pestañas',
			\ 'k' : ['tablcose'	,		 'Cerrar pestaña'],
			\ 'n' : ['tabedit'	,	'Abrir nueva pestaña'],
			\}


let g:which_key_map.w = {
			\ 'name' : '+VimWiki',
			\ 'i' : ['<Plug>VimwikiDiaryIndex'	,	 'Abrir índice de diario'],
			\ 's' : ['<Plug>VimwikiUISelect'	,		   'Seleccionar wiki'],
			\ 't' : ['<Plug>VimwikiTabIndex'	,	'Abrir índice en pestaña'],
			\ 'w' : ['<Plug>VimwikiIndex'		,	'Abrir índice de VimWiki'],
			\}


let g:which_key_map.w['space'] = {
			\ 'name' : 'Más VimWiki',
			\ 'i' : ['<Plug>VimwikiDiaryGenerateLinks'		,		  'Anexar entradas de diario a índice'],
			\ 'm' : ['<Plug>VimwikiMakeTomorrowDiaryNote'	,		  'Agregar entrada de mañana a diario'],
			\ 't' : ['<Plug>VimwikiTabMakeDiaryNote'		,	'Crear entrada de diario en pestaña nueva'],
			\ 'w' : ['<Plug>VimwikiMakeDiaryNote'			, 				   'Agregar entrada al diario'],
			\ 'y' : ['<Plug>VimwikiMakeYesterdayDiaryNote'	,		   'Agregar entrada de ayer al diario'],
			\}

