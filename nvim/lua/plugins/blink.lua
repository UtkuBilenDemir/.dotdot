return {
  "saghen/blink.cmp",
  enabled = true,
  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
  },
  opts = {
    completion = {
      ghost_text = {
        enabled = false,
      },
      list = {
        selection = {
          -- First item is auto-selected when menu opens.
          -- Enter accepts it. S-CR cancels menu and inserts a newline instead.
          preselect = true,
        },
      },
    },
    -- mini.snippets handles expansion and tabstop navigation.
    snippets = { preset = "mini_snippets" },
    sources = {
      default = { "snippets", "path", "lsp", "buffer" },
      per_filetype = {
        markdown = { inherit_defaults = true, "bib" },
      },
      providers = {
        bib = {
          name = "Bib",
          module = "bib_source",
          score_offset = 900,
        },
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          kind = "LSP",
          fallbacks = { "snippets", "buffer" },
          score_offset = 950,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
          fallbacks = { "snippets", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        snippets = {
          name = "snippets",
          enabled = true,
          module = "blink.cmp.sources.snippets",
          score_offset = 500,
          -- mini.snippets owns the snippet list and expansion.
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          score_offset = 950,
        },
      },
    },
    keymap = {
      preset = "default",
      -- Tab / S-Tab: mini.snippets owns tabstop navigation via its own keymaps.
      -- blink falls back so mini.snippets keymaps in mini-snippets.lua take over.
      ["<Tab>"] = { "fallback" },
      ["<S-Tab>"] = { "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<S-CR>"] = { "cancel", "fallback" },  -- newline without accepting
      ["<C-z>"] = { "select_and_accept", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    },
  },
}
