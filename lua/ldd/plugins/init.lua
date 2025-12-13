-- Resolve the plugin root at runtime
local function plugin_root()
	local src = debug.getinfo(1, "S").source:sub(2)
	return vim.fn.fnamemodify(src, ":h")
end
local script_path = plugin_root() .. "/remote-open.sh"
-- for svelte inspector in package @sveltejs/vite-plugin-svelte
vim.env.LAUNCH_EDITOR = script_path

return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
}
