return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/ubd/Library/Mobile Documents/iCloud~md~obsidian/Documents/rhizome",
      },
    },

    templates = {
      folder = "08_templates",
    },
    notes_subdir = "02_zettelkasten",
    note_id_func = function(title)
      return os.date("%Y%m%d-%H%M%S")
    end,
    disable_frontmatter = true,

    -- Open URLs under cursor with the system browser
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,

    picker = {
      name = "telescope",
    },

    ui = { enable = false },
  },
}
