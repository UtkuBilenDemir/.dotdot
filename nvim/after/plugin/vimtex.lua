local g = vim.g

g.vimtex_compiler_progname = 'nvr'
g.vimtex_complete_recursive_bib = 1
g.vimtex_complete_enabled = 1
g.vimtex_latex_indent_enabled = 0

-- -- g.vimtex_quickfix_method = 'pplatex'
-- g.tex_conceal = ''
-- g.vimtex_quickfix_mode = 0
-- g.vimtex_view_forward_search_on_start = 0
-- g.vimtex_view_general_viewer = 'skim'
-- g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
g.vimtex_view_method = "skim"
g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given

-- This must be a dictionary, and {} gets converted to a list
-- g.vimtex_syntax_conceal_disable = 1


-- filetype plugin indent on
