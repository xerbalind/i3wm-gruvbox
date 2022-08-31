local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
	vim.notify("jdtls not found!!")
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
require("cmp_nvim_lsp").update_capabilities(capabilities)

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name

local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java11_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		"/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		"/usr/share/java/jdtls/config_linux",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
	capabilities = capabilities,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			format = {
				enabled = false,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			signatureHelp = { enabled = true },
			-- completion = {
			-- 	"org.hamcrest.MatcherAssert.assertThat",
			-- 	"org.hamcrest.Matchers.*",
			-- 	"org.hamcrest.CoreMatchers.*",
			-- 	"org.junit.jupiter.api.Assertions.*",
			-- 	"java.util.Objects.requireNonNull",
			-- 	"java.util.Objects.requireNonNullElse",
			-- 	"org.mockito.Mockito.*",
			-- },
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
				},
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},

	on_attach = function(client, bufnr)
		-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
		-- you make during a debug session immediately.
		-- Remove the option if you do not want that.
		client.resolved_capabilities.document_formatting = false
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
}

local bundles = {
	vim.fn.glob(
		"/home/xander/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.35.0.jar"
	),
}
vim.list_extend(bundles, vim.split(vim.fn.glob("/home/xander/java/vscode-java-test/server/*.jar"), "\n"))
config["init_options"] = {
	bundles = bundles,
}

jdtls.start_or_attach(config)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
vim.api.nvim_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
