-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/blink-cmp.lua

-- completion plugin with support for LSPs and external sources that updates
-- on every keystroke with minimal overhead

-- https://www.lazyvim.org/extras/coding/blink
-- https://github.com/saghen/blink.cmp
-- Documentation site: https://cmp.saghen.dev/

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
        --show_with_selection = false,
      },
    },
    sources = {
      default = { "snippets", "path", "lsp", "buffer" },
      providers = {
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
          -- preset = "luasnip",
          score_offset = 1000,
          opts = {
            search_paths = { "/Users/ubd/.config/nvim/lua/snips" },
          },
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          score_offset = 950,
        },
      },
    },
    -- snippets = {
    --   expand = function(snippet)
    --     require("luasnip").lsp_expand(snippet)
    --   end,
    --   active = function(filter)
    --     if filter and filter.direction then
    --       return require("luasnip").jumpable(filter.direction)
    --     end
    --     return require("luasnip").in_snippet()
    --   end,
    --   jump = function(direction)
    --     require("luasnip").jump(direction)
    --   end,
    -- },
    keymap = {
      preset = "default",
      ["<C-z>"] = { "select_and_accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
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
