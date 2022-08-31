local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig not found!!")
	return
end

require("config.lsp.lsp-installer")
require("config.lsp.handlers").setup()
require("config.lsp.null-ls")
