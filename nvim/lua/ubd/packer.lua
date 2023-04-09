--packer = require 'packer'
-- Use a protected call so we don't error out on first use
-- TODO: Should we declare it globally?
-- TODO: Find out if ultisnips still better
-- TODO: Migrate to luaSnip
--
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Packer didn't work")
    return
end

packer.init({
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        open_fn = require("packer.util").float, -- An optional function to open a window for packer's display
        working_sym = "...", -- The symbol for a plugin being installed/updated
        error_sym = "!", -- The symbol for a plugin with an error in installation/updating
        done_sym = "+", -- The symbol for a plugin which has completed installation/updating
        removed_sym = "x", -- The symbol for an unused plugin which was removed
        moved_sym = "->", -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = "-", -- The symbol for the header line in packer's display
        show_all_info = true, -- Should packer show all update details automatically?
        prompt_border = "double", -- Border style of prompt popups.
        keybindings = { -- Keybindings for the display window
            quit = "q",
            toggle_info = "<CR>",
            diff = "d",
            prompt_revert = "r",
        },
    },
})

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]])

---------- PACKER
--
-- Lazy loading example:
-- Load on specific commands
-- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
--
local use = packer.use
packer.reset()

packer.startup(function(use)
    use("wbthomason/packer.nvim") -- PACKER

    -- LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        { 'saadparwaiz1/cmp_luasnip' },
      }
    }
    -- -- snippets
    -- use { 'saadparwaiz1/cmp_luasnip' }
    use { "rafamadriz/friendly-snippets"} -- a bunch of snippets to use

    -- -- Telescope
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- -- Treesitter
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

    -- -- vimtex
    use('lervag/vimtex')

    -- -- Colorscheme
    -- RosePine
    use({ 'rose-pine/neovim', as = 'rose-pine' })

    -- -- Other
    use('mbbill/undotree')
    use("tpope/vim-fugitive")
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Shows html markown preview
    -- use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" })
end)
