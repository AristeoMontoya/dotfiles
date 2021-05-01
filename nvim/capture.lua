V = vim

function FileExists(fileName)
	local file = io.open(fileName, 'r')
	local exists = file ~= nil
	io.close(file)
	return exists
end

function AddStamps(entryTitle, date, home, fileName)
	local title = '# Notas de ' .. entryTitle
	local entry = '- [ ] [[' .. date .. ']]\n'

	-- io objects
	local capturesIndex = io.open(home .. '/notas/capturas/capturas.md', 'a')
	local todaysCapture = io.open(fileName, 'w')
	io.output(capturesIndex)
	io.write(entry)

	io.output(todaysCapture)
	io.write(title)
	io.close()
end

function NormCapture(fileName, home, timestamp)
	V.cmd('tabedit ' .. fileName)
	V.cmd('tcd ' .. home .. '/notas')
	V.cmd('norm Go')
	V.cmd('norm Go' .. '## ' .. timestamp)
	V.cmd('norm G2o')
	V.cmd('norm zz')
	V.cmd('startinsert')
end

local home = os.getenv('HOME')
local date = os.date('%Y-%m-%d')
local entryTitle = os.date('%A %d de %B de %Y')
local timestamp = os.date('%H:%M')
local fileName = home .. '/notas/capturas/' .. date .. '.md'

if not FileExists(fileName) then
	AddStamps(entryTitle, date, home, fileName)
end

NormCapture(home, fileName, timestamp)
