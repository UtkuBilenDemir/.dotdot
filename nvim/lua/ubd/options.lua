-- :help options
local opt = vim.opt -- to set options
opt.encoding = "utf-8"
-- opt.foldmethod = "indent"
opt.expandtab = true -- use spaces instead of tabs
opt.number = true -- show line numbers
opt.relativenumber = true
opt.hlsearch = true -- highlight found searches
opt.ignorecase = true -- ignore case in search patterns
opt.tabstop = 4 -- 4 spaces for each tab
opt.shiftwidth = 4 -- I don't actually know what this is
opt.termguicolors = true
-- opt.smartindent = false
-- opt.autoindent = false
-- opt.cindent = false
-- opt.indentexpr = ""
opt.textwidth = 80
opt.mouse = "a" -- allow mouse

-- vim.cmd'colorscheme everforest'
-- vim.cmd'colorscheme nord' Nord if iTerm2, everforest if Alacritty
vim.g.everforest_background='hard'
vim.cmd'colorscheme everforest'

