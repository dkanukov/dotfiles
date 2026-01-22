return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	keys = {
		{ "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DB UI" },
		{ "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Add DB connection" },
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
	end,
	config = function()
		-- Add completion for sql files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			end,
		})
	end,
}
