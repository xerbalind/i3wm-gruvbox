local status_ok, dodona = pcall(require, "dodona")
if not status_ok then
	vim.notify("nvim-tree not found!!")
	return
end

dodona.setup({
	token = "CYOR0gnhC7TQ4d_mQZn7CGf_xh4XRe3yK9YqO7qcREY",
	base_url = "https://dodona.ugent.be",
})
