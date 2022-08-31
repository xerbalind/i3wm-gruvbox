local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	vim.notify("Lsp-installer not found!!")
	return
end

local my_arduino_fqbn = {
	["/home/xander/dev/arduino/blink"] = "arduino:avr:nano",
	["/home/xander/dev/arduino/sensor"] = "arduino:mbed:nanorp2040connect",
}

local DEFAULT_FQBN = "arduino:avr:uno"

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "arduino_language_server" then
		opts.on_new_config = function(config, root_dir)
			local partial_cmd = server:get_default_options().cmd
			local fqbn = my_arduino_fqbn[root_dir]
			if not fqbn then
				vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, DEFAULT_FQBN))
				fqbn = DEFAULT_FQBN
			end
			config.cmd = vim.list_extend(partial_cmd, { "-fqbn", fqbn })
		end
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
