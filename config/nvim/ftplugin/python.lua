-- vim.cmd(
--   [[nnoremap <leader>r :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
-- )
-- vim.cmd(
--   [[nnoremap <leader>R :w <bar> !tmux split-window -h "python3 -i %:r.py; echo '$(tput setaf 2)[finished...]'; read"<CR><CR>]]
-- )

local python_run = [[
  :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"
]]
local python_run_interactive = [[
  :w <bar> !tmux split-window -h "python3 %:r.py; echo '$(tput setaf 2)[finished...]'; read"
]]

vim.keymap.set("n", "<leader>rr", python_run, {
  noremap = true,
  silent = true,
  buffer = true,
  desc = "Run python",
})

vim.keymap.set("n", "<leader>rR", python_run_interactive, {
  noremap = true,
  silent = true,
  buffer = true,
  desc = "Run python (interactive)",
})
