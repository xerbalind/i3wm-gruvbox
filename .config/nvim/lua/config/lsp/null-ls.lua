local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	vim.notify("null-ls not found!!")
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

-- use rc files for project formatting arguments
null_ls.setup({
	debug = false,
	sources = { -- Sources needs to be installed in system && use  NullInfo to find out supported sources
		-- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.clang_format,
		-- diagnostics.flake8,

		-- html
		diagnostics.tidy,

		-- javascript
		-- formatting.eslint,
		-- diagnostics.eslint,
		-- code_actions.eslint,
	},

	on_attach = function(client)
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.cmd([[
		--           augroup LspFormatting
		--               autocmd! * <buffer>
		--               autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		--           augroup END
		--           ]])
		-- end
	end,
})
