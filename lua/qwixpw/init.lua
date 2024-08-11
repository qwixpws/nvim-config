require("qwixpw.set")
require("qwixpw.remap")

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

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

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Function to set theme based on file type
function set_theme_for_filetype()
  local filetype = vim.bo.filetype

  if filetype == 'cpp' then
    vim.cmd('colorscheme thematrix')
  elseif filetype == 'javascript' then
    vim.cmd('colorscheme tokyonight-moon')
  elseif filetype == 'lua' then
    vim.cmd('colorscheme tokyonight-day')
  else
    vim.cmd('colorscheme tokyonight')
  end
end

-- Set theme on filetype change
vim.cmd([[
  augroup ThemeChange
    autocmd!
    autocmd FileType * lua set_theme_for_filetype()
  augroup END
]])

