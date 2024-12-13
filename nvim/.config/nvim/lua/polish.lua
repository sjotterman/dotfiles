-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.cmd [[command! Qa :qa]]
vim.cmd [[command! Qall :qa]]
vim.cmd [[command! Q :q]]

vim.cmd [[
augroup jslint
  autocmd!
  au BufNewFile,BufRead *.js set makeprg=yarn\ lint\ --format\ unix
  au BufNewFile,BufRead *.jsx set makeprg=yarn\ lint\ --format\ unix
  au BufNewFile,BufRead *.ts set makeprg=yarn\ lint\ --format\ unix
  au BufNewFile,BufRead *.tsx set makeprg=yarn\ lint\ --format\ unix
augroup END

command! -nargs=0 Lint :make <bar> copen
]]
