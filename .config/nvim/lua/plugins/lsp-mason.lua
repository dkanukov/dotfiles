return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },

	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = {
					buffer = event.buf
				}

				vim.keymap.set('n', 'vh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({ 'n', 'x' }, 'fm', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
			end
		})


		local default_setup = function(server)
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
			lspconfig[server].setup({
				capabilities = lsp_capabilities
			})
		end

		require("mason").setup({})

		require('mason-lspconfig').setup({
			ensure_installed = { "cssls", "css_variables", "cssmodules_ls", "eslint", "stylelint_lsp", "lua_ls",
				"rust_analyzer", "bashls", "typos_lsp" },
			handlers = { default_setup }
		})
	end
}
