return {
	"nvimdev/guard.nvim",
	dependencies = {
		"nvimdev/guard-collection",
	},
	event = "BufReadPre",

	config = function()
		vim.g.guard_config = {
			fmt_on_save = true,
			lsp_as_default_formatter = true,
		}

		local ft = require("guard.filetype")

		-- Lua: stylua formatter
		ft("lua"):fmt("stylua")

		-- JavaScript/TypeScript: eslint --fix (respects project .eslintrc, can run prettier via plugin)
		ft("javascript,typescript,javascriptreact,typescriptreact"):fmt({
			cmd = "eslint_d",
			args = { "--fix-to-stdout", "--stdin", "--stdin-filename" },
			fname = true,
			stdin = true,
		})

		-- CSS/SCSS: stylelint --fix (respects project config)
		ft("css,scss"):fmt({
			cmd = "stylelint",
			args = { "--fix", "--stdin", "--stdin-filename" },
			fname = true,
			stdin = true,
		})

		-- Rust: rustfmt
		ft("rust"):fmt("rustfmt")

		-- Go: gofmt + goimports
		ft("go"):fmt("gofmt"):append("goimports")

		-- Shell: shfmt
		ft("sh,bash"):fmt("shfmt")

		-- JSON/YAML/Markdown: prettier (non-daemon, always reads project config)
		ft("json,yaml,markdown"):fmt({
			cmd = "prettier",
			args = { "--stdin-filepath" },
			fname = true,
			stdin = true,
		})
	end,
}
