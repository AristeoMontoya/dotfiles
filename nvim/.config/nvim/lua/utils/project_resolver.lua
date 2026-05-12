local M = {}

M.markers = {
	-- VCS
	".git",
	".hg",
	".svn",
	".jj",

	-- JavaScript / TypeScript
	"package.json",
	"pnpm-workspace.yaml",
	"deno.json",
	"deno.jsonc",

	-- Rust
	"Cargo.toml",

	-- Go
	"go.mod",

	-- Python
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"Pipfile",
	"uv.lock",

	-- Java / Kotlin
	"pom.xml",
	"build.gradle",
	"build.gradle.kts",
	"settings.gradle",

	-- Ruby
	"Gemfile",

	-- PHP
	"composer.json",

	-- C / C++
	"CMakeLists.txt",
	"Makefile",
	"meson.build",

	-- C# / .NET
	"global.json",

	-- Swift
	"Package.swift",

	-- Dart / Flutter
	"pubspec.yaml",

	-- Elixir
	"mix.exs",

	-- Haskell
	"stack.yaml",
	"cabal.project",

	-- Scala
	"build.sbt",

	-- Clojure
	"project.clj",
	"deps.edn",

	-- Lua / Neovim
	"lazy-lock.json",
	".luarc.json",
	"stylua.toml",

	-- Nix
	"flake.nix",

	-- Terraform
	".terraform",

	-- Generic
	".editorconfig",
	".envrc",
}

--- Return the root plus N ancestor segments above it.
---@param root string Absolute path returned by M.get()
---@param parents integer How many levels above root to include
---@return string
local function with_parents(root, parents)
	if not parents or parents <= 0 then
		return root
	end

	local parts = {}
	local p = root
	for _ = 1, parents do
		local up = vim.fn.fnamemodify(p, ":h")
		if up == p then
			break
		end -- hit fs root, stop
		table.insert(parts, 1, vim.fn.fnamemodify(p, ":t"))
		p = up
	end
	table.insert(parts, 1, vim.fn.fnamemodify(p, ":t"))

	return table.concat(parts, "/")
end

--- Resolve the project root for a given buffer.
--- Priority:
---   1. LSP root_dir (most authoritative)
---   2. vim.fs.root() walking up from the file
---   3. The file's own directory (final fallback)
---
---@param opts? { buf?: integer, use_lsp?: boolean, parents?: integer }
---@return string
function M.get(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	local use_lsp = opts.use_lsp ~= false

	-- 1. LSP
	if use_lsp then
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
			if client.config.root_dir then
				local root = client.config.root_dir
				return with_parents(root, opts.parents) -- <--
			end
		end
	end

	-- 2. vim.fs.root
	local root = vim.fs.root(buf, M.markers)
	if root then
		return with_parents(root, opts.parents) -- <--
	end

	-- 3. Fallback
	local path = vim.api.nvim_buf_get_name(buf)
	local fallback = path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.uv.cwd()
	return with_parents(fallback, opts.parents) -- <--
end

function M.current()
	return M.get()
end

function M.cd(opts)
	local root = M.get(opts)
	vim.fn.chdir(root)
	vim.notify("Project root: " .. root, vim.log.levels.INFO)
end

return M
