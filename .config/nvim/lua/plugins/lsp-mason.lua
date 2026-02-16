return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },

	config = function()
		-- Diagnostic display configuration
		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 2 },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚",
					[vim.diagnostic.severity.WARN] = "󰀪",
					[vim.diagnostic.severity.HINT] = "󰌶",
					[vim.diagnostic.severity.INFO] = "󰋽",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				border = "rounded",
				source = true,
			},
		})

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
				vim.keymap.set({ 'n', 'x' }, 'fm', '<cmd>Guard fmt<cr>', opts)
				vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
				vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
				vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
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
			ensure_installed = {
				"cssls",
				"css_variables",
				"cssmodules_ls",
				"stylelint_lsp",
				"lua_ls",
				"rust_analyzer",
				"bashls",
				"typos_lsp",
				"jsonls",
				"yamlls",
				"html",
			},
			handlers = {
				default_setup,
				-- Disable ts_ls since typescript-tools handles TypeScript
				ts_ls = function() end,
				-- Disable eslint LSP - Guard uses eslint_d instead
				eslint = function() end,
				-- JSON with schema support
				jsonls = function()
					require("lspconfig").jsonls.setup({
						capabilities = require('cmp_nvim_lsp').default_capabilities(),
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
				-- YAML with schema support
				yamlls = function()
					require("lspconfig").yamlls.setup({
						capabilities = require('cmp_nvim_lsp').default_capabilities(),
						settings = {
							yaml = {
								schemaStore = {
									enable = false,
									url = "",
								},
								schemas = require("schemastore").yaml.schemas(),
							},
						},
					})
				end,
			}
		})
	end
}
