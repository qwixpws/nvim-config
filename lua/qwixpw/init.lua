require("qwixpw.set")
require("qwixpw.remap")

local augroup = vim.api.nvim_create_augroup
local Qwixpw = augroup('Qwixpw', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local langmapEnabled = true

vim.g.my_lang = false
function ToggleLangmap()
    if langmapEnabled then
        vim.o.langmap = ""
    else
        vim.o.langmap =
        "йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж;,э\\',яz,чx,сc,мv,иb,тn,ьm,б.,ю/"
    end
    langmapEnabled = not langmapEnabled
end

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = Qwixpw,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Function to set the theme based on filetype
function set_theme_for_filetype()
    local filetype = vim.bo.filetype

    if filetype == "lua" then
        vim.cmd("colorscheme tokyonight")
    elseif (filetype == "cpp" or filetype == "c") then
        vim.cmd("colorscheme thematrix")
    elseif filetype == "javascript" or filetype == "js" then
        vim.cmd("colorscheme sorbet")
    elseif filetype == "typescript" then
        vim.cmd("colorscheme tokyonight-moon")
    else
        -- Set a default colorscheme if the filetype doesn't match
        vim.cmd("colorscheme slate")
    end

    -- Set transparent background
    --vim.cmd("highlight Normal guibg=none")
    --vim.cmd("highlight NonText guibg=none")
end

-- Auto command to trigger the theme change on buffer enter
vim.cmd([[
  augroup ThemeChange
    autocmd!
    autocmd BufEnter * lua set_theme_for_filetype()
  augroup END
]])
vim.cmd [[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]]

-- Set theme on filetype change
--vim.cmd([[
--augroup ThemeChange
--autocmd!
--autocmd FileType lua colorscheme tokyonight-day
--autocmd FileType cpp colorscheme thematrix
--autocmd FileType javascript colorscheme tokyonight-moon
--augroup END
--]])
