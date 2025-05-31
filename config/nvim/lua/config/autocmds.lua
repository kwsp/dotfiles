-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown note taking
vim.api.nvim_create_user_command("Notes", function()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    callback = function()
      local file = vim.fn.expand("%")
      local outfile = vim.fn.fnamemodify(file, ":r") .. ".html"
      local cmd = string.format(
        "pandoc -s --katex='https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/' --highlight-style pygments --toc %s -o %s",
        vim.fn.shellescape(file),
        vim.fn.shellescape(outfile)
      )

      vim.fn.jobstart(cmd, {
        stderr_buffered = true,
        on_stderr = function(_, data)
          if data and data[1] ~= "" then
            vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "Pandoc Error" })
          end
        end,
      })
    end,
  })
end, {})
