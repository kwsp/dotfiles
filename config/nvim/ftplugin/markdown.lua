-- Markdown note taking
-- vim.cmd(
--   [[command! Notes autocmd BufWritePost *.md silent !pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.13.18/dist/' --highlight-style pygments --toc % -o %:r.html ]]
-- )

local autocmd_group = vim.api.nvim_create_augroup("MarkdownNotes_" .. vim.api.nvim_buf_get_name(0), {
  clear = true,
})

vim.api.nvim_create_user_command("Notes", function()
  -- clear old autocmd
  vim.api.nvim_clear_autocmds({ group = autocmd_group, event = "BufWritePost" })

  -- create new autcmd
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = autocmd_group,
    desc = "Run pandoc on save for Markdown notes",
    buffer = 0,
    callback = function()
      local pandoc_cmd =
        [[!pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.16.25/dist/' --highlight-style pygments --toc % -o %:r.html  ]]
      vim.cmd("silent " .. vim.fn.expand(pandoc_cmd))
    end,
  })

  -- notify
  vim.notify("Autocommand set: HTML will be generate on save.", vim.log.levels.INFO)
end, {
  nargs = 0,
  desc = "Setup BufWritePost to generate HTML via Pandoc on save",
})
