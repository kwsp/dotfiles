set nocompatible
filetype plugin indent on
syntax on
set hidden
set cmdheight=1
set nobackup
set nowritebackup
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
set termguicolors
set noshowmode
set shortmess+=c
set number
set mouse=a

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim  --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin(stdpath('data') . '/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/nerdtree'
		map <C-n> :NERDTreeToggle<CR>
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim',
		nnoremap <c-p> :FZF<CR>
		nnoremap ; :Buffers<CR>
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'jiangmiao/auto-pairs'
    Plug 'pangloss/vim-javascript'
    let g:javascript_plugin_jsdoc = 1
    Plug 'vim-python/python-syntax'
		let g:python_highlight_func_calls = 1
		let g:python_highlight_operators = 1
    Plug 'kovisoft/slimv'
    let g:slimv_swank_cmd = '!tmux new-window -d -n REPL-SBCL "sbcl --load ~/.local/share/nvim/plugged/slimv/slime/start-swank.lisp"'
    let g:lisp_rainbow=1
    Plug 'neoclide/jsonc.vim'
		Plug 'vim-airline/vim-airline'
    Plug 'kwsp/halcyon-neovim'
    Plug 'honza/vim-snippets'
call plug#end()

colorscheme halcyon
so ~/.config/nvim/coc-shortcuts.vim

" Shortcuts
" Switch between tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt


" competitive programming
autocmd filetype c nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; gcc % -o %:r.out && sh -c ./%:r.out); echo '$(tput setaf 2)[finished...]'; read"<CR>
autocmd filetype cpp nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; g++ -std=c++17 % -o %:r.out && sh -c ./%:r.out); echo '$(tput setaf 2)[finished...]'; read"<CR><CR>
autocmd filetype cpp nnoremap <leader>tp :read ~/.config/nvim/templates/skeleton.cpp<CR>kdd5j
