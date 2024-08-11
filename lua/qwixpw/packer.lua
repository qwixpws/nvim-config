-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')
vim.api.nvim_set_var('f', '0fh=i<Tab><Esc>j')
vim.api.nvim_set_var('q', '02xj')
vim.o.termguicolors = true

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('telescope').setup({
                defaults = {
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { " " },
                    },
                }
            })
        end
    }

    use {
        'luisiacc/the-matrix.nvim',
        config = function()
            local colors = require('thematrix.colors').config()
            vim.g.thematrix_use_original_pallete = 0
            vim.g.thematrix_transparent_mode = 1
            vim.g.thematrix_function_style = "NONE"
            vim.g.thematrix_keyword_style = "italic"
            vim.g.thematrix_highlights = { Normal = { fg = colors.foreground, bg = "NONE", style = "underline" } }
            vim.g.thematrix_background_color = {}
            vim.g.thematrix_telescope_theme = 1
            --vim.g.thematrix_comment_style = "NONE"
            --vim.cmd[[colorscheme thematrix]],
        end
    }
    --use {
    --'jose-elias-alvarez/null-ls.nvim',
    --config = function()
    --require('null-ls').setup({
    --sources = {
    --require('null-ls').builtins.formatting.prettier
    --}
    --})
    --end
    --}

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            --vim.cmd('colorscheme rose-pine')
        end
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")
    --use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim")
    use({
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd('colorscheme tokyonight-moon')
        end
    })
end)
