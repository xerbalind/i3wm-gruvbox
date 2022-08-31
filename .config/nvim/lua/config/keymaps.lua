local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>G", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>s", "<cmd>Telescope grep_string<cr>", opts)
-- keymap("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", opts)

--LSP
-- keymap("n", "<Tab>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- keymap("n", "<S-Tab>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

-- Debugger
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)

-- Buffer mappings
-- Goto buffer in position...
keymap("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<A-0>", ":BufferLast<CR>", opts)

--Close Buffer
keymap("n", "<A-c>", ":bdelete<CR>", opts)
