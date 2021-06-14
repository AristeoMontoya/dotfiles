V = vim

function FileExists(fileName)
	local file = io.open(fileName, 'r')
	if file ~= nil then
		io.close(file)
		return true
	else
		return false
	end
end

-- Agrega al índice la captura pendiente de revisión
function AddPendingCapture(date, home)
	local entry = '- [ ] [' .. date .. '](capturas/' .. date .. ')\n'
	local index = io.open(home .. '/notas/index.md', 'a')
	io.output(index)
	io.write(entry)
	io.close()
end

function AddStamps(date, home, fileName)
	local entryTitle = os.date('%A %d de %B de %Y')
	local title = '# Notas de ' .. entryTitle
	local entry = '- [[' .. date .. ']]\n'
	local capturesIndex = io.open(home .. '/notas/capturas/capturas.md', 'a')
	local todaysCapture = io.open(fileName, 'w')
	io.output(capturesIndex)
	io.write(entry)

	io.output(todaysCapture)
	io.write(title)
	io.close()
end

function LinkExists(index, date)
	local pattern = '(- \\[[ |X]\\] \\['..date..'\\]\\(.*))'
	local command = 'grep -E "'..pattern..'" ' .. index
	local existe = os.execute(command)
	-- Por alguna razón Lua maneja true como 512, por lo menos dentro
	-- de nvim
	return existe == 512
end

-- Busca si está marcada la revisión y la deja sin revisar
-- Anteriormente usaba io, pero causa segfault en neovim
function UpdateIndex(index, date)
	-- Sed puede usar el delimitador se que sea, para no estar escapando
	-- caracteres estoy usando +
	if LinkExists(index, date) then
		local target = '- \\[X\\] \\[' ..date.. '\\]\\(.*\\)'
		local replacement = '- [ ] [' ..date.. '](capturas/' ..date.. ')'
		os.execute('sed -i "s+'..target..'+'..replacement..'+g" '..index)
	else
		AddPendingCapture(date, os.getenv('HOME'))
	end
end

function PrepareCapture(home, date, fileName)
	if not FileExists(fileName) then
		AddStamps(date, home, fileName)
		AddPendingCapture(date, home)
	else
		UpdateIndex(home.. '/notas/index.md', date)
	end
end

function StartInsert(fileName, timestamp)
	V.cmd('edit ' .. fileName)
	V.cmd('norm Go')
	V.cmd('norm Go' .. '## ' .. timestamp)
	V.cmd('norm G2o')
	V.cmd('norm zz')
	V.cmd('startinsert')
end

function CreateCapture()
	local home = os.getenv('HOME')
	local date = os.date('%Y-%m-%d')
	local timestamp = os.date('%H:%M')
	local fileName = home .. '/notas/capturas/' .. date .. '.md'

	PrepareCapture(home, date, fileName)
	StartInsert(fileName, timestamp)
end

CreateCapture()
