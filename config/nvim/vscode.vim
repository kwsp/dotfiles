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
set scrolloff=100   " cursor always at the center of the screen
let g:mapleader = "\<Space>" "remap leader

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim  --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin(stdpath('data') . '/plugged')
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
call plug#end()
