-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 79
vim.opt.colorcolumn = "80"
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  command = "highlight ColorColumn guibg=#403d52",
})

-- Ensure wrapped lines don't break in the middle of words
vim.opt.linebreak = true

-- Set scrolloff to create a margin around the text
vim.opt.scrolloff = 999

-- Dynamically set the window's minimum and maximum width
vim.opt.winwidth = 80
vim.opt.winminwidth = 80
