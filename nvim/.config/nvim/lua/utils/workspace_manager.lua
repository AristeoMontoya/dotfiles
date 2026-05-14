local M = {}
local snacks = require("snacks")
local project_resolver = require("utils.project_resolver")

local uv = vim.uv or vim.loop

M.workspace_root = vim.fn.stdpath("data") .. "/workspaces"

local function ensure_workspace_root()
	vim.fn.mkdir(M.workspace_root, "p")
end

local function workspace_path(name)
	return M.workspace_root .. "/" .. name
end

local function workspace_preview_renderer(ctx)
	local item = ctx.item

	if not item then
		return false
	end

	local workspace = workspace_path(item.text)
	local lines = {}

	table.insert(lines, "# " .. item.text)
	table.insert(lines, "")
	table.insert(lines, "Folders:")
	table.insert(lines, "")

	local entries = uv.fs_scandir(workspace)

	if entries then
		while true do
			local name = uv.fs_scandir_next(entries)

			if not name then
				break
			end

			local full = workspace .. "/" .. name
			local target = uv.fs_readlink(full)

			if target then
				table.insert(lines, ("󰉋 %s"):format(name))
				table.insert(lines, ("   -> %s"):format(target))
			else
				table.insert(lines, ("󰉋 %s"):format(name))
			end

			table.insert(lines, "")
		end
	end

	vim.bo[ctx.buf].modifiable = true

	vim.api.nvim_buf_set_lines(ctx.buf, 0, -1, false, lines)

	vim.bo[ctx.buf].modifiable = false
	vim.bo[ctx.buf].filetype = "markdown"

	return true
end

local function scandir(path)
	local handle = uv.fs_scandir(path)

	if not handle then
		return {}
	end

	local items = {}

	while true do
		local name, type = uv.fs_scandir_next(handle)

		if not name then
			break
		end

		if type == "directory" then
			table.insert(items, name)
		end
	end

	table.sort(items)

	return items
end

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, {
		title = "Workspace Manager",
	})
end

local function restart_lsp()
	local clients = vim.lsp.get_clients()

	for _, client in ipairs(clients) do
		client:stop()
	end

	if #clients > 0 then
		vim.defer_fn(function()
			vim.cmd("edit")

			notify("LSP restarted")
		end, 300)
	end
end

local function cd(path)
	vim.cmd.cd(vim.fn.fnameescape(path))

	restart_lsp()

	notify("Changed workspace to: " .. path)
end

local function add_symlink(source, workspace)
	source = vim.fn.fnamemodify(source, ":p")
	source = source:gsub("/$", "")

	local stat = uv.fs_stat(source)

	if not stat or stat.type ~= "directory" then
		notify("Invalid directory", vim.log.levels.ERROR)
		return false
	end

	local name = vim.fs.basename(source)
	local target = workspace .. "/" .. name

	if uv.fs_stat(target) then
		notify(("Target already exists: %s"):format(name), vim.log.levels.ERROR)
		return false
	end

	local ok, err = uv.fs_symlink(source, target)

	if not ok then
		notify(("Failed to create symlink: %s"):format(err), vim.log.levels.ERROR)
		return false
	end

	notify(("Added folder '%s'"):format(name))

	return true
end

function M.create_workspace()
	ensure_workspace_root()

	local current_project = project_resolver.get()

	vim.ui.input({
		prompt = "Workspace name: ",
	}, function(input)
		if not input or input == "" then
			return
		end

		local path = workspace_path(input)

		if uv.fs_stat(path) then
			notify("Workspace already exists", vim.log.levels.ERROR)
			return
		end

		vim.fn.mkdir(path, "p")

		-- Add project BEFORE cd
		if current_project then
			local confirmed = vim.fn.confirm(("Add current project?\n\n%s"):format(current_project), "&Yes\n&No", 1)

			if confirmed == 1 then
				add_symlink(current_project, path)
			end
		end

		cd(path)

		restart_lsp()
	end)
end

function M.open_workspace()
	ensure_workspace_root()

	local workspaces = scandir(M.workspace_root)

	if vim.tbl_isempty(workspaces) then
		notify("No workspaces found", vim.log.levels.WARN)
		return
	end

	snacks.picker.pick({
		title = "Open Workspace",

		items = vim.tbl_map(function(name)
			return {
				text = name,
			}
		end, workspaces),

		format = function(item)
			return {
				{ item.text, "Directory" },
			}
		end,

		preview = workspace_preview_renderer,

		confirm = function(picker, item)
			picker:close()

			if not item then
				return
			end

			local path = workspace_path(item.text)

			cd(path)
		end,
	})
end

function M.delete_workspace()
	ensure_workspace_root()

	local workspaces = scandir(M.workspace_root)

	if vim.tbl_isempty(workspaces) then
		notify("No workspaces found", vim.log.levels.WARN)
		return
	end

	snacks.picker.pick({
		title = "Delete Workspace",

		items = vim.tbl_map(function(name)
			return {
				text = name,
				value = name,
			}
		end, workspaces),

		format = function(item)
			return {
				{ item.text, "Directory" },
			}
		end,

		preview = workspace_preview_renderer,

		confirm = function(picker, item)
			picker:close()

			if not item then
				return
			end

			local path = workspace_path(item.value)

			local confirmed = vim.fn.confirm(("Delete workspace '%s'?"):format(item.value), "&Yes\n&No", 2)

			if confirmed ~= 1 then
				return
			end

			vim.fn.delete(path, "rf")

			notify("Deleted workspace: " .. item.value)
		end,
	})
end

function M.add_folder()
	local cwd = vim.fn.getcwd()

	if not vim.startswith(cwd, M.workspace_root) then
		notify("Current directory is not a managed workspace", vim.log.levels.ERROR)
		return
	end

	local input = vim.fn.input("Directory to add: ", vim.fn.getcwd() .. "/", "dir")

	if not input or input == "" then
		return
	end

	if add_symlink(input, cwd) then
		restart_lsp()
	end
end

return M
