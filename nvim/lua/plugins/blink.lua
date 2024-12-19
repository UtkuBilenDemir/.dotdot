return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      --"L3MON4D3/LuaSnip",
    },
    opts = {
      keymap = {
        preset = "super-tab", -- or 'super-tab', 'enter' based on your preference
      },
      sources = {
        default = { "lsp", "path", "buffer", "snippets" }, -- Ensure 'snippets' is enabled
      },
      snippets = {
        opts = {
          search_paths = {
            vim.fn.stdpath("config") .. "/lua/snips/latex_snips.json",
          },
        },
        --provider = "luasnip", -- Ensure LuaSnip is the snippet engine
        --custom_path = vim.fn.stdpath("config") .. "/lua/snips/", -- Replace with your snippets directory
      },
    },
  },
}
