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
opt.softtabstop = 4
opt.shiftwidth = 4 -- I don't actually know what this is
opt.expandtab = true

opt.termguicolors = true
-- opt.smartindent = false
-- opt.autoindent = false
-- opt.cindent = false
-- opt.indentexpr = ""
opt.textwidth = 80
vim.cmd('set nowrap')
opt.mouse = "a" -- allow mouse
vim.cmd('syntax enable')
opt.scrolloff = 8
-- opt.colorcolumn = "80"
opt.signcolumn = "yes"

---- Transparent background ------------------------------------------------------
vim.cmd'autocmd!'
vim.cmd'autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE'
vim.cmd'autocmd ColorScheme * highlight SignColumn guibg=NONE'
vim.cmd'autocmd ColorScheme * highlight TabLineFill ctermfg=NONE ctermbg=NONE'
vim.cmd'autocmd ColorScheme * highlight TabLine ctermfg=NONE ctermbg=NONE'
vim.cmd'autocmd ColorScheme * highlight TabLineSel ctermfg=NONE ctermbg=NONE'
vim.cmd'autocmd ColorScheme * highlight Title ctermfg=NONE ctermbg=NONE'

---- Colorscheme -----------------------------------------------------------------
-- vim.cmd'colorscheme rose-pine'
require('rose-pine').setup({
    disable_background = true
})

function ColorMyPencils(color) 
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()

