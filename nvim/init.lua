-- *** LUA CONFIG *** --

-- TODO: gitignore this one
require("ubd.python")

require("ubd.rosepine")
require("ubd.keymaps")
require("ubd.plugins")
require("ubd.cmp")
require("ubd.lsp")
require("ubd.telescope")
require("ubd.treesitter")
require("ubd.autopairs")
require("ubd.comment")
require("ubd.gitsigns")
require("ubd.nvim-tree")
require("ubd.bufferline")
require("ubd.toggleterm")
require("ubd.vimtex")
require("ubd.lualine")
require("ubd.indent-blankline")
require("ubd.options")

require'pandoc'.setup()
require"fidget".setup{}

vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"
