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
opt.termguicolors = true
opt.smartindent = false
opt.autoindent = false
opt.cindent = false
opt.textwidth = 80
opt.mouse = "a" -- allow mouse

vim.cmd'colorscheme everforest'
