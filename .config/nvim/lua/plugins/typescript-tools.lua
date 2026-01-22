return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	keys = {
		{ "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
		{ "<leader>ru", "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove unused" },
		{ "<leader>ai", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add missing imports" },
		{ "<leader>fa", "<cmd>TSToolsFixAll<cr>", desc = "Fix all" },
		{ "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "Rename file" },
	},
	opts = {
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "change",
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "none",
				includeInlayFunctionParameterTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				-- Enable auto-imports for JS files
				includeCompletionsForModuleExports = true,
				includeCompletionsWithSnippetText = true,
			},
			-- Treat JS files more like TS for better import support
			tsserver_plugins = {},
			expose_as_code_action = "all",
		},
	},
}
