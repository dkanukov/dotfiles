return {
	"greggh/claude-code.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("claude-code").setup({
			-- Default keybinding is <C-,> to toggle Claude Code terminal
			window_type = "float",
			float_config = {
				width = 0.9, -- 90% of editor width
				height = 0.9, -- 90% of editor height
				border = "rounded",
			},
		})
	end,
}
