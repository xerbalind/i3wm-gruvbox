local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	-- Colorscheme
	use("ellisonleao/gruvbox.nvim")

	-- CMP (completion) plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippet plugins
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Code Runner
	use({ "CRAG666/code_runner.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Java
	use("mfussenegger/nvim-jdtls")

	--Debugging
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("mfussenegger/nvim-dap-python")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- Better telescope sorting

	-- Autopairs
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter

	-- Commenting
	use("JoosepAlviste/nvim-ts-context-commentstring") -- context commenting
	use("numToStr/Comment.nvim") -- easily comment stuff

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- NVim tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})

	-- Buffers configuration
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("moll/vim-bbye")

	-- Lualine
	use("nvim-lualine/lualine.nvim")

	-- ToggleTerm
	use("akinsho/toggleterm.nvim")

	-- Which-key
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")

	-- Project
	use("ahmedkhalf/project.nvim")

	-- Alpha
	use({
		"goolord/alpha-nvim",
	})


	-- Dodona Plugin
	use({
		"xerbalind/dodona.nvim",
		requires = {
			"rcarriga/nvim-notify",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	--Github copilot
	-- use({ "github/copilot.vim" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
