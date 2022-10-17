vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.api.nvim_exec([[ autocmd BufRead,BufNewFile *.py set shiftwidth=4 ]], false)
vim.o.clipboard = "unnamedplus"

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-surround'
  use 'preservim/nerdcommenter'
  use 'tpope/vim-repeat' -- '.' repeating for the above plugins
end)

-- VSCode specific commands
vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>call VSCodeNotify("workbench.action.focusBelowGroup")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>call VSCodeNotify("workbench.action.focusAboveGroup")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<Cmd>call VSCodeNotify("workbench.action.focusLeftGroup")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<Cmd>call VSCodeNotify("workbench.action.focusRightGroup")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-\\>', '<Cmd>call VSCodeNotify("workbench.action.focusPreviousGroup")<CR>', { noremap = true, silent = true })

-- go to prev/next issue
vim.api.nvim_set_keymap('n', ']d', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>', { noremap = true, silent = true })
