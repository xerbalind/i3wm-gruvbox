local status_ok, dodona = pcall(require, "dodona")
if not status_ok then
	vim.notify("nvim-tree not found!!")
	return
end

dodona.setup({
	token = "<token-here>",
	base_url = "https://dodona.ugent.be",
})
