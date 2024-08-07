" ============================================================================ "
" ===                               Neovim config                          === "
" ============================================================================ "
scriptencoding utf-8
set encoding=utf-8
syntax enable
filetype plugin indent on
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent set smartindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set clipboard+=unnamedplus  " All yank to system clipboard
set path+=**
set backspace=indent,eol,start " Fixes common backspace problems
set mouse=a 
set noshiftround
set scrolloff=2
set nobackup
set nowritebackup
set noswapfile
set signcolumn=auto
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_nz
set autoread        " Auto reread file if a change was detected
set scrolloff=100   " cursor always at the center of the screen
let g:mapleader = "\<Space>" "remap leader

" ============================================================================ "
" ===                               VimPlug                                === "
" ============================================================================ "
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Editing
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'

" Git plugin
Plug 'tpope/vim-fugitive'
let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gE :Gedit<space>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gR :Gread<space>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gW :Gwrite!<CR>
nnoremap <silent> <leader>gq :Gwq<CR>
nnoremap <silent> <leader>gQ :Gwq!<CR>

" Status line
Plug 'itchyny/lightline.vim'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',

" Syntax highlighting
Plug 'leafgarland/typescript-vim',
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'peitalin/vim-jsx-typescript'

" Theme
Plug 'chuling/vim-equinusocio-material'

" Grammar
Plug 'rhysd/vim-grammarous'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Tex
Plug 'lervag/vimtex'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" LaTeX
"let g:vimtex_latexmk_progname = 'nvr'
"let g:vimtex_view_method = 'zathura'
"let g:vimtex_fold_manual=1
"let g:vimtex_quickfix_ignore_all_warnings = 0
"let g:vimtex_quickfix_open_on_warning = 0
"let g:vimtex_fold_enabled = 1
"
"let g:formatdef_latexindent = '"latexindent"'
"let g:formatters_tex = ['latexindent']
"
"let g:tex_flavor='latex'
"let g:tex_indent_brace=1
"let g:tex_indent_items=1
"let g:tex_items='\\bibitem\|\\item'
"let g:tex_itemize_env='itemize\|description\|enumerate\|thebibliography'
"let g:tex_noindent_env='document\|verbatim\|comment\|lstlisting'
"let g:tex_indent_ifelsefi = 1
"let g:tex_indent_and=1
"let g:tex_conceal="abdgm"

" Markdown
let g:mkdp_page_title = '${name}'
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 1 } }
"autocmd FileType org,markdown :TableModeToggle

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "
set hidden
set number          " show line number
set wildmenu        " autocomplete for command menu
set showmatch       " highlight matching brace
set laststatus=2    " Always have status line
set noshowmode      " Lightline already show mode
set showcmd
set termguicolors
"set notermguicolors
set cmdheight=1     " One line for command line
set shortmess+=c    " don't give completion messages
set splitbelow      " Set preview window to appear at bottom

if has('nvim')
  set winbl=10        " Set floating window to be slightly transparent
endif

" Search
set hlsearch        " Highlight matching search patterns
set incsearch       " Enable incremental search
set ignorecase      " Ignore case when searching
set smartcase       " Include only uppercase words with uppercase search term

" Set floating window background
hi Pmenu guibg=Black


"""" Theme settings
" if you prefer the default one, comment out this line
"let g:equinusocio_material_darker = 1

" make vertsplit invisible
let g:equinusocio_material_hide_vertsplit = 1

colorscheme equinusocio_material

hi Normal ctermbg=None

" === Nerdtree toggle === "
map <C-n> :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

" === split navigation === "
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) "
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction

nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Opening splits with terminal in all directions
nnoremap <Leader>h<Enter> :leftabove  vnew<CR>:terminal<CR>
nnoremap <Leader>l<Enter> :rightbelow vnew<CR>:terminal<CR>
nnoremap <Leader>k<Enter> :leftabove  new<CR>:terminal<CR>
nnoremap <Leader>j<Enter> :rightbelow new<CR>:terminal<CR>


" === fzf === "
nnoremap <c-p> :FZF<CR>
nnoremap ; :Buffers<CR>
nnoremap <Leader>w :Windows<CR>
nnoremap <Leader>/ :BLines<CR>
nnoremap <Leader>? :Lines<CR>
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>


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

" Nvim escape terminal
tnoremap <Esc> <C-\><C-n>

"
" === coc config
"

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "
":hi ErrorMsg ctermfg=15 ctermbg=1 guifg=black guibg=Red
