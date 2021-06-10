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

local home = os.getenv('HOME')
local date = os.date('%Y-%m-%d')
local entryTitle = os.date('%A %d de %B de %Y')
local timestamp = os.date('%H:%M')

local fileName = home .. '/notas/capturas/' .. date .. '.md'

if not FileExists(fileName) then
	AddStamps(entryTitle, date, home, fileName)
	AddPendingCapture(date, home)
end

V.cmd('tabedit ' .. fileName)
V.cmd('tcd ' .. home .. '/notas')
V.cmd('norm Go')
V.cmd('norm Go' .. '## ' .. timestamp)
V.cmd('norm G2o')
V.cmd('norm zz')
V.cmd('startinsert')
