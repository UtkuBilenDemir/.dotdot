return {
  --# Colorscheme
  --  { "rose-pine/neovim", name = "rose-pine" },
  -- Seems to be the only transparent setting actually working
  --# Tex Utilities
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "lervag/vimtex",
    init = function()
      -- Use init for configuration, don't use the more common "config".
    end,
  },
}
