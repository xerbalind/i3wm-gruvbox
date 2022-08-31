local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

-- local hide_in_width = function()
-- 	return vim.fn.winwidth(0) > 80
-- end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	-- Displays diagnostics for the defined severity types
	sections = { "error", "warn" },

	symbols = { error = "E ", warn = "W " },

	diagnostic_color = {
		error = "DiagnosticError", -- Changes diagnostics' error color.
		warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
	},

	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,

	diff_color = {
		-- Same color values as the general color option can be used here.
		added = "DiffAdd", -- Changes the diff's added color
		modified = "DiffChange", -- Changes the diff's modified color
		removed = "DiffDelete", -- Changes the diff's removed color you
	},

	symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
	source = nil,
}

local mode = {
	"mode",
	separator = nil,
	cond = nil,
	-- fmt = function(str)
	-- 	return "-- " .. str .. " --"
	-- end,
}

-- local filetype = {
-- 	"filetype",
-- 	icons_enabled = false,
-- 	icon = nil,
-- }

local filename = {
	"filename",
	file_status = true,
	path = 0,
	symbols = {
		modified = "[+]", -- Text to show when the file is modified.
		readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
	},
}

local branch = {
	"branch",
	icons_enabled = false,
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "Top", "Middle", "Bottom" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "▎", right = "▎" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diff },
		lualine_c = { diagnostics },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { spaces, "encoding", filename },
		lualine_y = { progress },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
