--- Returns the amount of opened files.
--- @alias utils.CountListedFiles fun(): integer

--- @type utils.CountListedFiles
return function()
	local count = 0
	local all_buffers = vim.api.nvim_list_bufs()

	for _, buf_id in ipairs(all_buffers) do
		-- Check if the buffer is 'listed'
		if vim.fn.buflisted(buf_id) ~= 0 then
			count = count + 1
		end
	end
	return count
end
