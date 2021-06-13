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

function AddStamps(entryTitle, date, home, fileName)
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

function GetFileContent(filename)
	local file = io.open(filename, 'r')
	local content = file.read(file, '*a')
	io.close()
	return content
end

-- Busca si está marcada la revisión y la deja sin revisar
function UpdateIndex(index)
	local content = GetFileContent(index)
	local file = io.open(index, 'w')
	local target = '- %[X%] %[' .. os.date('%Y%%-%m%%-%d').. ']'
	local replacement = '- [ ] [' ..os.date('%Y-%m-%d').. ']'
	content = string.gsub(content, target, replacement)
	io.output(file)
	io.write(content)
	io.close(file)
end

local home = os.getenv('HOME')
local date = os.date('%Y-%m-%d')
local entryTitle = os.date('%A %d de %B de %Y')
local timestamp = os.date('%H:%M')

local fileName = home .. '/notas/capturas/' .. date .. '.md'

if not FileExists(fileName) then
	AddStamps(entryTitle, date, home, fileName)
	AddPendingCapture(date, home)
else
	UpdateIndex(home.. '/notas/index.md')
end

print('Simón')

V.cmd('edit ' .. fileName)
V.cmd('tcd ' .. home .. '/notas')
V.cmd('norm Go')
V.cmd('norm Go' .. '## ' .. timestamp)
V.cmd('norm G2o')
V.cmd('norm zz')
V.cmd('startinsert')
