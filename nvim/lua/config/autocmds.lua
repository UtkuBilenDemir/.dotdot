-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Override LazyVim's checktime autocmd (keep original behavior).
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = vim.api.nvim_create_augroup("lazyvim_checktime", { clear = true }),
  command = "checktime",
})

-- Suppress E211 when Obsidian Templater renames a note: if the file was
-- deleted/renamed externally, do nothing instead of showing an error.
vim.api.nvim_create_autocmd("FileChangedShell", {
  group = vim.api.nvim_create_augroup("obsidian_file_renamed", { clear = true }),
  callback = function()
    if vim.v.fcs_reason == "deleted" then
      vim.v.fcs_choice = ""
    end
  end,
})
