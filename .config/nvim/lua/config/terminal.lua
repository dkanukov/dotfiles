local M = {}

function M.setup()
	local map = vim.keymap.set

	map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Terminal: to Normal mode' })
	map('t', 'jk', [[<C-\><C-n>]], { desc = 'Terminal: to Normal mode' })

	map('n', 'ts', function() vim.cmd('split | terminal') end, { desc = 'Terminal split' })
	map('n', 'tv', function() vim.cmd('vsplit | terminal') end, { desc = 'Terminal vsplit' })

	local function focus_or_open_terminal_tab()
		for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buftype == 'terminal' then
					vim.api.nvim_set_current_tabpage(tab)
					vim.api.nvim_set_current_win(win)
					return
				end
			end
		end
		vim.cmd('tabnew | terminal')
	end

	map('n', '<leader>tn', focus_or_open_terminal_tab, { desc = 'Terminal tab (focus or create)' })
end

return M
