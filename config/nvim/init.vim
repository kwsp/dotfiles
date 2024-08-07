set nocompatible
filetype plugin indent on
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
set scrolloff=2
let g:mapleader = "\<Space>" "remap leader
set termguicolors
set noshowmode
set shortmess+=c
set number
set mouse=a
set conceallevel=2
map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D>


if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim  --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin(stdpath('data') . '/plugged')
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'preservim/nerdcommenter'
    Plug 'preservim/nerdtree'
		map <C-n> :NERDTreeToggle<CR>

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim',
		nnoremap <c-p> :FZF<CR>
		nnoremap ; :Buffers<CR>

    Plug 'christoomey/vim-tmux-navigator'
    
    "" Markdown folds, syntax highlight (maths)
    Plug 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
    let g:vim_markdown_new_list_item_indent = 0
    
    Plug 'jpalardy/vim-slime', { 'for': ['python', 'markdown'] }
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
    let g:slime_dont_ask_default = 1

    Plug 'vim-airline/vim-airline'
    Plug 'kwsp/halcyon-neovim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  }
}
EOF

colorscheme halcyon
so ~/.config/nvim/coc-shortcuts.vim
so ~/.config/nvim/debug.vim

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

" delete buffer
nmap <leader>d :bdelete<CR>

" competitive programming
autocmd filetype cpp nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; g++ -std=c++20 % -o %:r.out); ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>
autocmd filetype cpp nnoremap <leader>tp :read ~/.config/nvim/templates/skeleton.cpp<CR>kdd5j
autocmd filetype python nnoremap <leader>r :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>
autocmd filetype python nnoremap <leader>R :w <bar> !tmux split-window -h "python3 -i %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>
autocmd filetype go nnoremap <leader>r :w <bar> !tmux split-window -h "go run %:r.go; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>

" markdown note taking
command! Notes autocmd BufWritePost *.md silent !pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.13.18/dist/' --highlight-style pygments --toc % -o %:r.html
