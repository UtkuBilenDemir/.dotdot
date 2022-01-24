-- TODO: Do you use buffers?
-- TODO: FInd a way to process Option key as Alt
-- Alternatively, you can move to Kitty terminal (which has that option)

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- Remap space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


---------- NORMAL
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Open Lexplorer
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

---------- INSERT

---------- VISUAL
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Don't replace the yanked with deleted
keymap("v", "p", '"_dP', opts) 

---------- VISUAL BLOCK
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<C-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- TODO: previewer = false ?
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes'))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>f", ":Format<cr>", opts)
