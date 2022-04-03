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
autocmd BufWritePost plugins.lua source <afile> | PackerSync
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

    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

    -- cmp plugins
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    -- snippets
    use("L3MON4D3/LuaSnip") --snippet engine
    use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

    -- LSP
    use("neovim/nvim-lspconfig") -- enable LSP
    use("williamboman/nvim-lsp-installer") -- simple to use language server installer
    use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
    use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

    -- Telescope
    use("nvim-telescope/telescope.nvim")

    -- Treesitter -- Don't update automatically, tmux messes it up
    -- use({
    --  "nvim-treesitter/nvim-treesitter",
    --  run = ":TSUpdate",
    -- })
    use("nvim-treesitter/nvim-treesitter")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("p00f/nvim-ts-rainbow")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Git
    use("lewis6991/gitsigns.nvim")

    -- LaTeX
    use "lervag/vimtex"

    -- Colorscheme
    use("sainnhe/everforest")
    use("shaunsingh/nord.nvim")
    use("rose-pine/neovim")

    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }


    -- MISC.
    use "jiangmiao/auto-pairs" -- auto bracket etc. pairs
    use("numToStr/Comment.nvim") -- Easily comment stuff
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")
    use("akinsho/bufferline.nvim")
    use("moll/vim-bbye")
    use("akinsho/toggleterm.nvim")
    use("j-hui/fidget.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("aspeddro/pandoc.nvim")


    -- Zen Mode
    -- Lua
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- Shows html markown preview
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", cmd = "MarkdownPreview" })
end)
