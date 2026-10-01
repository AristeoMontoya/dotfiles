---Hunk navigation shared by every plugin that has a notion of hunks.
---Plugins register a handler, so the keymaps don't need to know about any of them.
local M = {}

---@alias HunkDirection "next"|"prev"

local handlers = {} ---@type { fn: fun(direction: HunkDirection): boolean?, priority: integer }[]

---@param handler fun(direction: HunkDirection): boolean? Returns true when it handled the jump
---@param priority? integer Higher runs first, defaults to 0
function M.register(handler, priority)
	table.insert(handlers, { fn = handler, priority = priority or 0 })
	table.sort(handlers, function(a, b)
		return a.priority > b.priority
	end)
end

---@param direction HunkDirection
local function navigate(direction)
	for _, handler in ipairs(handlers) do
		if handler.fn(direction) then
			return
		end
	end

	if vim.wo.diff then
		vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true })
	end
end

function M.next()
	navigate("next")
end

function M.prev()
	navigate("prev")
end

return M
