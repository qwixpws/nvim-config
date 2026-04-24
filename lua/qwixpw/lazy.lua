-- Глобальные настройки
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
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────────
-- Вспомогательная функция (используется zen-mode)
-- ─────────────────────────────────────────────
function ColorMyPencils(color)
    color = color or "tokyonight-moon"
    vim.cmd.colorscheme(color)
end

-- ─────────────────────────────────────────────
-- Плагины
-- ─────────────────────────────────────────────
local plugins = {

    -- ── Telescope ──────────────────────────────
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                defaults = {
                    borderchars = {
                        prompt  = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { " " },
                    },
                },
            })

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>',      builtin.git_files,  {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end,
    },

    -- ── The Matrix colorscheme ─────────────────
    {
        'luisiacc/the-matrix.nvim',
        config = function()
            local colors = require('thematrix.colors').config()
            vim.g.thematrix_use_original_pallete  = 0
            vim.g.thematrix_transparent_mode      = 1
            vim.g.thematrix_function_style        = "NONE"
            vim.g.thematrix_keyword_style         = "italic"
            vim.g.thematrix_highlights            = {
                Normal = { fg = colors.foreground, bg = "NONE", style = "underline" },
            }
            vim.g.thematrix_background_color      = {}
            vim.g.thematrix_telescope_theme       = 1
        end,
    },

    -- ── Rose-pine colorscheme ──────────────────
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_background = true,
            })
        end,
    },

    -- ── Tokyo Night (активная тема) ────────────
    {
        "folke/tokyonight.nvim",
        lazy     = false,
        priority = 1000,
        config   = function()
            ColorMyPencils()
        end,
    },

    -- ── Transparent ────────────────────────────
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
            extra_groups   = {},
            exclude_groups = {},
            on_clear       = function() end,
        },
    },

    -- ── Trouble ────────────────────────────────
    {
        "folke/trouble.nvim",
        opts = { icons = false },
        config = function(_, opts)
            require('trouble').setup(opts)
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
                { silent = true, noremap = true })
        end,
    },

    -- ── Treesitter ─────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        lazy  = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = { "cpp", "javascript", "typescript", "c", "lua", "rust" },
                sync_install     = false,
                auto_install     = true,
                highlight        = {
                    enable                            = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- ── Harpoon ────────────────────────────────
    {
        "theprimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui   = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>",     ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end,
    },

    -- ── Refactoring ────────────────────────────
    {
        "theprimeagen/refactoring.nvim",
        config = function()
            local ok, refactoring = pcall(require, "refactoring")
            if not ok then return end

            refactoring.setup({})

            vim.keymap.set("v", "<leader>ri", function()
                refactoring.refactor('Inline Variable')
            end, { desc = "Refactor: Inline Variable" })
        end,
    },

    -- ── Undotree ───────────────────────────────
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },

    -- ── Fugitive ───────────────────────────────
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

            local group   = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})
            local autocmd = vim.api.nvim_create_autocmd

            autocmd("BufWinEnter", {
                group    = group,
                pattern  = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then return end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts  = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git('push')
                    end, opts)

                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git({ 'pull', '--rebase' })
                    end, opts)

                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
                end,
            })
        end,
    },

    -- ── Treesitter context ─────────────────────
    "nvim-treesitter/nvim-treesitter-context",

    -- ── LSP Zero v4 ────────────────────────────
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            -- Keymaps при подключении LSP
            lsp_zero.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd",          function() vim.lsp.buf.definition()       end, opts)
                vim.keymap.set("n", "K",            function() vim.lsp.buf.hover()            end, opts)
                vim.keymap.set("n", "<leader>vws",  function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd",   function() vim.diagnostic.open_float()    end, opts)
                vim.keymap.set("n", "[d",           function() vim.diagnostic.goto_next()     end, opts)
                vim.keymap.set("n", "]d",           function() vim.diagnostic.goto_prev()     end, opts)
                vim.keymap.set("n", "<leader>vca",  function() vim.lsp.buf.code_action()      end, opts)
                vim.keymap.set("n", "<leader>vrr",  function() vim.lsp.buf.references()       end, opts)
                vim.keymap.set("n", "<leader>vrn",  function() vim.lsp.buf.rename()           end, opts)
                vim.keymap.set("i", "<C-h>",        function() vim.lsp.buf.signature_help()   end, opts)
            end)

            -- Иконки диагностики
            lsp_zero.ui({
                float_border = 'rounded',
                sign_icons   = { error = 'E', warn = 'W', hint = 'H', info = 'I' },
            })

            -- Mason + автонастройка серверов
            require('mason').setup({})
            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    ['lua_ls'] = function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { 'vim' } },
                                },
                            },
                        })
                    end,
                },
            })

            -- nvim-cmp
            local cmp        = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer',  keyword_length = 3 },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>']     = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>']     = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>']     = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })

            -- Глобальная конфигурация диагностики
            vim.diagnostic.config({ virtual_text = true })
        end,
    },

    -- ── Zen Mode ───────────────────────────────
    {
        "folke/zen-mode.nvim",
        config = function()
            -- Вариант с числами и rnu
            vim.keymap.set("n", "<leader>zz", function()
                require("zen-mode").setup({
                    window = { width = 90, options = {} },
                })
                require("zen-mode").toggle()
                vim.wo.wrap   = false
                vim.wo.number = true
                vim.wo.rnu    = true
                ColorMyPencils()
            end)

            -- Вариант без номеров строк
            vim.keymap.set("n", "<leader>zZ", function()
                require("zen-mode").setup({
                    window = { width = 80, options = {} },
                })
                require("zen-mode").toggle()
                vim.wo.wrap          = false
                vim.wo.number        = false
                vim.wo.rnu           = false
                vim.opt.colorcolumn  = "0"
                ColorMyPencils()
            end)
        end,
    },

    -- ── Cloak ──────────────────────────────────
    {
        "laytan/cloak.nvim",
        config = function()
            require("cloak").setup({
                enabled          = true,
                cloak_character  = "*",
                highlight_group  = "Comment",
                patterns         = {
                    {
                        file_pattern  = { ".env*", "wrangler.toml", ".dev.vars" },
                        cloak_pattern = "=.+",
                    },
                },
            })
        end,
    },

    -- ── Codeium ────────────────────────────────
    {
        'Exafunction/codeium.vim',
        config = function() end,
    },

    -- ── Прочие ─────────────────────────────────
    "eandrju/cellular-automaton.nvim",
}

-- ─────────────────────────────────────────────
-- Инициализация Lazy
-- ─────────────────────────────────────────────
require("lazy").setup(plugins)
