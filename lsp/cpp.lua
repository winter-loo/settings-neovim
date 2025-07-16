return {
	cmd = {
		-- If you have a custom installed clangd, you may need set
		-- your clangd full path.
		--
		-- And if you build clangd from source using custom installed g++,
		-- you may need set your g++ full path in ~/.config/clangd/config.yaml
		-- Example.
		-- ```config.yaml
		-- CompileFlags:
		--   Add: [-xc++, -Wall]   # treat all files as C++, enable more warnings
		--   Compiler: /data/ludd50155/alt/gcc-10.5.0/bin/g++
		-- ```
		--
		-- TIPS: you could have .clangd file in your project root and add some
		-- include directories or compilation flags in it.
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},

	filetypes = { "c", "cc", "cpp", "h", "hpp" },

	root_markers = { ".clangd", "compile_commands.json", ".clang-format", ".git" },
}
