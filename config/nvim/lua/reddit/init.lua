local api = vim.api
local buf, win
local position = 0

local M = {}

local function set_mappings()
  local mappings = {
    ['['] = 'update_view(-1)',
    [']'] = 'update_view(1)',
    ['<cr>'] = 'open_file()',
    h = 'update_view(-1)',
    l = 'update_view(1)',
    q = 'close_window()',
    k = 'move_cursor()',
  }

  for k, v in pairs(mappings) do
    api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"reddit".' .. v .. '<cr>',
      { nowait = true, noremap = true, silent = true })
  end

  -- Set keymaps
  api.nvim_buf_set_keymap(buf, 'n', 'x', ':echo "wow!"<cr>', { nowait = true, noremap = true, silent = true })

  -- Disable unused keys
  --local other_chars = {
  --'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  --}
  --for k, v in ipairs(other_chars) do
  --api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
  --api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
  --api.nvim_buf_set_keymap(buf, 'n', '<c-' .. v .. '>', '', { nowait = true, noremap = true, silent = true })
  --end

end

local function open_window()
  buf = api.nvim_create_buf(false, true) -- create new empty buffer
  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- get dims
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  -- calculate our floating window size
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  -- and its starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  -- set some options
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  win = api.nvim_open_win(buf, true, opts)
end

local function close_window()
  api.nvim_win_close(win, true)
end

local function move_cursor()
  local new_pos = math.max(4, api.nvim_win_get_cursor(win)[1] - 1)
  api.nvim_win_set_cursor(win, { new_pos, 0 })
end

local function open_file()
  local str = api.nvim_get_current_line()
  close_window()
  api.nvim_command('edit ' .. str)
end

local function center(txt)
  local width = api.nvim_win_get_width(0)
  local shift = math.floor(width / 2) - math.floor(string.len(txt) / 2)
  return string.rep(' ', shift) .. txt
end

local function update_view(direction)
  position = position + direction
  if position < 0 then position = 0 end

  -- we will use vim systemlist function which run shell
  -- command and return result as a list
  local result = vim.fn.systemlist('git diff-tree --no-commit-id --name-only -r HEAD~'..position)

  -- with small indentation results will look better
  for k, v in pairs(result) do
    result[k] = '  ' .. v
  end

  api.nvim_buf_set_lines(buf, 0, -1, false, {
    center("What have I done?"),
    center('HEAD~'..position),
    ''
  })
  api.nvim_buf_set_lines(buf, 3, -1, false, result)
end

local function reddit()
  position = 0
  open_window()
  set_mappings()
  update_view(0)
  api.nvim_win_set_cursor(win, {4, 0})
  --move_cursor()
end

M.open_window = open_window
M.update_view = update_view
M.open_file = open_file
M.move_cursor = move_cursor
M.close_window = close_window
M.reddit = reddit

vim.api.nvim_set_keymap('n', '<leader>r', "<cmd>lua require('reddit').reddit()<CR>", { noremap = true, silent = true })

return M
