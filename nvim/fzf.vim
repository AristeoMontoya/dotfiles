" Files + devicons
function! Fzf_dev()
	if &ft == 'vimwiki'
		"Si está en VimWiki, se busca en notas únicamente
		NV
	elseif len(system("git -C . rev-parse")) < 1
		" Si el directorio es un repositorio se usa GFiles
		GFiles
	elseif system('echo -n $PWD') != '/home/aristeo'
		let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

		function! s:files()
			let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
			return s:prepend_icon(l:files)
		endfunction

		function! s:prepend_icon(candidates)
			let l:result = []
			for l:candidate in a:candidates
				let l:filename = fnamemodify(l:candidate, ':p:t')
				let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
				call add(l:result, printf('%s %s', l:icon, l:candidate))
			endfor

			return l:result
		endfunction

		function! s:edit_file(item)
			let l:pos = stridx(a:item, ' ')
			let l:file_path = a:item[pos+1:-1]
			execute 'silent e' l:file_path
		endfunction

		call fzf#run({
					\ 'source': <sid>files(),
					\ 'sink':	function('s:edit_file'),
					\ 'options': '-m ' . l:fzf_files_options,
					\ 'down':	 '40%' })
	else
		echo 'No se puede hacer búsqueda difusa en home.'
	endif
endfunction
