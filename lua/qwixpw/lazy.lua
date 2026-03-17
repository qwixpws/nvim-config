-- Глобальные настройки, которые были в начале packer.lua
vim.api.nvim_set_var('f', '0fh=i<Tab><Esc>j')
vim.api.nvim_set_var('q', '02xj')
vim.api.nvim_set_var('t', '0ea<Tab><Tab><Tab><Esc>j')
vim.o.termguicolors = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Список плагинов
local plugins = {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
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
    },

    {
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
        end
    },

    -- {
    --     'jose-elias-alvarez/null-ls.nvim',
    --     config = function()
    --         require('null-ls').setup({
    --             sources = {
    --                 require('null-ls').builtins.formatting.prettier
    --             }
    --         })
    --     end
    -- },

    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            --vim.cmd('colorscheme rose-pine')
        end
    },

    {
        "folke/trouble.nvim",
        opts = {
            icons = false,
            -- your configuration comes here
        }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },

    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "theprimeagen/refactoring.nvim",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "nvim-treesitter/nvim-treesitter-context",

    {
        "xiyaowong/transparent.nvim",
        opts = {
            groups = {
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                'EndOfBuffer',
            },
            extra_groups = {},
            exclude_groups = {},
            on_clear = function() end,
        }
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
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
    },

    -- {
    --     "aserowy/tmux.nvim",
    --     opts = {
    --         copy_sync = {
    --             enable = true,
    --             ignore_buffers = { empty = false },
    --             redirect_to_clipboard = false,
    --             register_offset = 0,
    --             sync_clipboard = true,
    --             sync_registers = true,
    --             sync_registers_keymap_put = true,
    --             sync_registers_keymap_reg = true,
    --             sync_deletes = true,
    --             sync_unnamed = true,
    --         },
    --         navigation = {
    --             cycle_navigation = true,
    --             enable_default_keybindings = true,
    --             persist_zoom = false,
    --         },
    --         resize = {
    --             enable_default_keybindings = true,
    --             resize_step_x = 1,
    --             resize_step_y = 1,
    --         }
    --     }
    -- },

    "folke/zen-mode.nvim",
    -- "github/copilot.vim",
    "eandrju/cellular-automaton.nvim",
    "laytan/cloak.nvim",

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme tokyonight-moon')
        end
    },

    {
        'Exafunction/codeium.vim',
        config = function()
        end
    }
}

-- Инициализация Lazy
require("lazy").setup(plugins)
