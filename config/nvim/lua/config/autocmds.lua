-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown note taking
vim.cmd(
  [[command! Notes autocmd BufWritePost *.md silent !pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.13.18/dist/' --highlight-style pygments --toc % -o %:r.html ]]
)

-- Competitive programming
vim.cmd(
  [[autocmd filetype cpp nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; g++ -std=c++20 % -o %:r.out); ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
)
vim.cmd([[autocmd filetype cpp nnoremap <leader>tp :read ~/.config/nvim/templates/skeleton.cpp<CR>kdd5j]])
vim.cmd(
  [[autocmd filetype python nnoremap <leader>r :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
)
vim.cmd(
  [[autocmd filetype python nnoremap <leader>R :w <bar> !tmux split-window -h "python3 -i %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
)
vim.cmd(
  [[autocmd filetype go nnoremap <leader>r :w <bar> !tmux split-window -h "go run %:r.go; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
)
