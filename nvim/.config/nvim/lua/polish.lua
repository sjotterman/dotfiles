vim.cmd [[command! Qa :qa]]
vim.cmd [[command! Qall :qa]]
vim.cmd [[command! Q :q]]

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function() vim.cmd "compiler eslint" end,
})

-- Custom :Lint command (runs make and opens quickfix only if there are items)
vim.api.nvim_create_user_command("Lint", function()
  vim.cmd "make"
  -- Only open quickfix if there are items to display
  if vim.fn.len(vim.fn.getqflist()) > 0 then vim.cmd "copen" end
end, {})
