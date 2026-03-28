-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Override LazyVim's checktime autocmd to suppress E211 when files are
-- renamed externally (e.g. Obsidian Templater renames notes after applying).
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("lazyvim_checktime", { clear = true }),
  command = "silent! checktime",
})
