local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>dn", "<Cmd>lua require'dap-python'.test_method()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dt", "<Cmd>lua require'dap-python'.test_class()<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>ds", "<Cmd>lua require'dap-python'.debug_selection()<CR>", opts)
