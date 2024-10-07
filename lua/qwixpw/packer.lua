-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')
vim.api.nvim_set_var('f', '0fh=i<Tab><Esc>j')
vim.api.nvim_set_var('q', '02xj')
vim.api.nvim_set_var('t', '0ea<Tab><Tab><Tab><Esc>j')
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

    use({
        "xiyaowong/transparent.nvim",
        config = function()
            return require("transparent").setup({
                -- table: default groups
                groups = {
                    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                    'EndOfBuffer',
                },
                -- table: additional groups that should be cleared
                extra_groups = {},
                -- table: groups you don't want to clear
                exclude_groups = {},
                -- function: code to be executed after highlight groups are cleared
                -- Also the user event "TransparentClear" will be triggered
                on_clear = function() end,
            })
        end
    })


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
    --use({
    --"aserowy/tmux.nvim",
    --config = function()
    --return require("tmux").setup(
    --{
    --copy_sync = {
    ---- enables copy sync. by default, all registers are synchronized.
    ---- to control which registers are synced, see the `sync_*` options.
    --enable = true,
    --
    ---- ignore specific tmux buffers e.g. buffer0 = true to ignore the
    ---- first buffer or named_buffer_name = true to ignore a named tmux
    ---- buffer with name named_buffer_name :)
    --ignore_buffers = { empty = false },
    --
    ---- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
    ---- clipboard by tmux
    --redirect_to_clipboard = false,
    --
    ---- offset controls where register sync starts
    ---- e.g. offset 2 lets registers 0 and 1 untouched
    --register_offset = 0,
    --
    ---- overwrites vim.g.clipboard to redirect * and + to the system
    ---- clipboard using tmux. If you sync your system clipboard without tmux,
    ---- disable this option!
    --sync_clipboard = true,
    --
    ---- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
    --sync_registers = true,
    --
    ---- synchronizes registers when pressing p and P.
    --sync_registers_keymap_put = true,
    --
    ---- synchronizes registers when pressing (C-r) and ".
    --sync_registers_keymap_reg = true,
    --
    ---- syncs deletes with tmux clipboard as well, it is adviced to
    ---- do so. Nvim does not allow syncing registers 0 and 1 without
    ---- overwriting the unnamed register. Thus, ddp would not be possible.
    --sync_deletes = true,
    --
    ---- syncs the unnamed register with the first buffer entry from tmux.
    --sync_unnamed = true,
    --},
    --navigation = {
    ---- cycles to opposite pane while navigating into the border
    --cycle_navigation = true,
    --
    ---- enables default keybindings (C-hjkl) for normal mode
    --enable_default_keybindings = true,
    --
    ---- prevents unzoom tmux when navigating beyond vim border
    --persist_zoom = false,
    --},
    --resize = {
    ---- enables default keybindings (A-hjkl) for normal mode
    --enable_default_keybindings = true,
    --
    ---- sets resize steps for x axis
    --resize_step_x = 1,
    --
    ---- sets resize steps for y axis
    --resize_step_y = 1,
    --}
    --
    --})
    --end
    --})
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

    use {
        'Exafunction/codeium.vim',
        config = function()
        end
    }
end)
