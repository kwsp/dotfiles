-- Original vimscript version
-- vim.cmd(
--   [[autocmd filetype cpp nnoremap <leader>r :w <bar> !tmux split-window -h "(set -x; g++ -std=c++20 % -o %:r.out); ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
-- )

-- Build and run
local cpp_run_debug = [[
  :w | !tmux split-window -h "(set -x; g++ -std=c++20 -g -O0 -Wall -Werror % -o %:r.out) && ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"
]]
local cpp_run_release = [[
  :w | !tmux split-window -h "(set -x; g++ -std=c++20 -O2 -Wall -Werror % -o %:r.out) && ./%:r.out; echo '$(tput setaf 2)[finished...]'; read"
]]

vim.keymap.set("n", "<leader>rd", cpp_run_debug, {
  noremap = true,
  silent = true,
  buffer = true,
  desc = "Build and run cpp (Debug)",
})

vim.keymap.set("n", "<leader>rr", cpp_run_release, {
  noremap = true,
  silent = true,
  buffer = true,
  desc = "Build and run cpp (Release)",
})

-- Copy from template
-- vim.cmd([[autocmd filetype cpp nnoremap <leader>tp :0r ~/.config/nvim/templates/skeleton.cpp<CR>}]])
vim.cmd([[nnoremap <leader>tp :0r ~/.config/nvim/templates/skeleton.cpp<CR>}]])
