local status_ok, neuron = pcall(require, "neuron")
if not status_ok then
	vim.notify("neuron not found!!")
	return
end

neuron.setup({
	virtual_titles = true,
	mappings = true,
	run = nil, -- function to run when in neuron dir
	neuron_dir = "~/Documents/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
	leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
})
