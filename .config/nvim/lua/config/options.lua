local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.cursorlineopt = "line"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Force LSP to refresh diagnostics after save (helps when formatters fix errors)
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.defer_fn(function()
			vim.diagnostic.reset()
			for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
				if client.supports_method("textDocument/diagnostic") then
					vim.lsp.buf_request(0, "textDocument/diagnostic", {
						textDocument = vim.lsp.util.make_text_document_params(),
					})
				end
			end
		end, 100)
	end,
})