set hidden
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd BufRead,BufNewFile *.py set shiftwidth=4
set expandtab
set smartindent
set autoindent
set copyindent
set clipboard+=unnamedplus
set autoread
set nrformats+=alpha,bin,hex
set ignorecase
set smartcase
set showmatch
let g:mapleader = "\<Space>" "remap leader

call plug#begin(stdpath('data') . '/plugged')
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
call plug#end()

""" VSCode specific commands
" Window navigation
nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>
nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>
nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>
nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>
nnoremap <C-\> <Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>
