local colorscheme = "gruvbox"

-- .. : concatenate string
-- pcall() : protected call
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    -- if colorscheme doesn't exist
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
