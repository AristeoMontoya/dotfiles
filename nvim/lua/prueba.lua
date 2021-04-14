-- function Capture()
-- 	let fecha = strftime('%Y-%m-%d')
-- 	let archivo = $HOME.'/notas/capturas/'.fecha.'.md'
-- 	if !filereadable(archivo)
-- 		let titulo = 'echo "# Notas de '.fecha.'" > '.archivo
-- 		call system(titulo)
-- 		let entrada = 'echo "- [['.fecha.']]" >> "'.$HOME.'/notas/capturas/capturas.md"'
-- 		call system(entrada)
-- 	endif

-- 	let timestamp = strftime('%H:%M')
-- 	execute 'tabedit' archivo
-- 	execute 'tcd' $HOME.'/notas'
-- 	execute 'norm Go'
-- 	execute 'norm Go'.'## '.timestamp
-- 	execute 'norm G2o'
-- 	execute 'norm zz'
-- 	execute 'startinsert'
-- endfunc

vim.cmd('echo "Buenos días desde lua en '.. fecha .. '"')
vim.cmd('echo "A ver'.. archivo .. '"')
vim.cmd('echo "A ver'.. respuesta .. '"')

function FileExists(fileName)
	local file = io.open(fileName, 'r')
	if file ~= nil then
		io.close(file)
		return true
	else
		return false
	end
end

function AddStamps(date, home, fileName)
	local titulo = '# Notas de ' .. date
	local entrada = '- [[' .. date .. ']]\n'
	local capturesIndex = io.open(home .. '/notas/capturas/capturas.md', 'a')
	local todaysCapture = io.open(fileName, 'w')
	io.output(capturesIndex)
	io.write(entrada)

	io.output(todaysCapture)
	io.write(titulo)
	io.close()
end

local home = os.getenv('HOME')
local date = os.date('%Y-%m-%d')
local fileName = home .. '/notas/capturas/' .. date .. '.md'
print(fileName)

if not FileExists(fileName) then
	-- AddStamps(date, home, fileName)
	print('a')
end

local timestamp = os.date('%H:%M')
print(timestamp)
