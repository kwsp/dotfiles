" ============================================================================ "
" ===                               Neovim config                          === "
" ============================================================================ "
scriptencoding utf-8
set encoding=utf-8
"syntax enable
filetype plugin indent on
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent set smartindent
autocmd BufRead,BufNewFile *.html,*.js,*css,*.ts,*.yaml,*.toml set shiftwidth=2  " 2 spaces for certain files
set expandtab       " tabs are space
set smartindent
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
set nrformats+=alpha 

set foldmethod=marker

let g:mapleader = "\<Space>" "remap leader

" Search
set hlsearch        " Highlight matching search patterns
set incsearch       " Enable incremental search
set ignorecase      " Ignore case when searching
set smartcase       " Include only uppercase words with uppercase search term

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
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'jiangmiao/auto-pairs'

" Git plugin
Plug 'tpope/vim-fugitive'
let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

" Status line
Plug 'itchyny/lightline.vim'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy find
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',

" Syntax highlighting
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1

" Common Lisp
Plug 'vlime/vlime', {'rtp': 'vim/'}

" Theme
Plug 'NieTiger/halcyon-neovim'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

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
set cmdheight=1     " One line for command line
set shortmess+=c    " don't give completion messages
set splitbelow      " Set preview window to appear at bottom

let g:lightline = {'colorscheme': 'halcyon'}
colorscheme halcyon

if has('nvim')
  set winbl=10        " Set floating window to be slightly transparent
endif

" Set floating window background
hi Pmenu guibg=Black
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
"nnoremap ; :Buffers<CR>
nnoremap <Leader>w :Windows<CR>                 " Search open windows
nnoremap <Leader>/ :BLines<CR>                  " Search in open buffers
nnoremap <Leader>? :Lines<CR>                   " Search in current directory
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
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

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



""" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "
":hi ErrorMsg ctermfg=15 ctermbg=1 guifg=black guibg=Red

function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off
   else
      syntax enable
   endif
endfunction
 
nmap <silent>  ;s  :call ToggleSyntax()<CR>

" Get syntax highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Reload vimrc
map <F9> :so ~/.vimrc <CR>

" Python documentation
nnoremap <F2> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

