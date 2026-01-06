-- Come back to this to use it without lualatex
return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
    end,
  },
}

--return {
--  {
--    "lervag/vimtex",
--    lazy = false, -- we don't want to lazy load VimTeX
--    -- tag = "v2.15", -- uncomment to pin to a specific release
--    init = function()
--      -- Viewer configuration (your existing setting)
--      vim.g.vimtex_view_method = "skim"
--
--      -- --- ENGINE FIX (IMPORTANT) ------------------------------------
--      -- Force VimTeX to use latexmk as compiler
--      vim.g.vimtex_compiler_method = "latexmk"
--
--      -- Tell latexmk to use LuaLaTeX instead of pdfLaTeX
--      -- This is REQUIRED when using fontspec
--      vim.g.vimtex_compiler_latexmk = {
--        options = {
--          "-lualatex", -- switch engine (critical)
--          "-pdf", -- generate PDF output
--          "-interaction=nonstopmode", -- do not stop on errors
--          "-synctex=1", -- enable forward/backward sync
--        },
--      }
--
--      -- Nuclear option: force LuaLaTeX even if something else overrides it
--      -- Safe to keep; prevents silent regressions
--      vim.g.vimtex_compiler_latexmk_engines = {
--        _ = "-lualatex",
--      }
--      -- ---------------------------------------------------------------
--    end,
--  },
--}
