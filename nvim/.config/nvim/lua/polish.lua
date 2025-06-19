vim.cmd [[command! Qa :qa]]
vim.cmd [[command! Qall :qa]]
vim.cmd [[command! Q :q]]

vim.cmd [[
augroup jslint
  autocmd!
  au BufNewFile,BufRead *.js set makeprg=yarn\ lint\ --format\ unix\ 2>&1\ \\\|\ grep\ -E\ '^[^\ ].*:[0-9]+:[0-9]+:'
  au BufNewFile,BufRead *.jsx set makeprg=yarn\ lint\ --format\ unix\ 2>&1\ \\\|\ grep\ -E\ '^[^\ ].*:[0-9]+:[0-9]+:'
  au BufNewFile,BufRead *.ts set makeprg=yarn\ lint\ --format\ unix\ 2>&1\ \\\|\ grep\ -E\ '^[^\ ].*:[0-9]+:[0-9]+:'
  au BufNewFile,BufRead *.tsx set makeprg=yarn\ lint\ --format\ unix\ 2>&1\ \\\|\ grep\ -E\ '^[^\ ].*:[0-9]+:[0-9]+:'
augroup END

command! -nargs=0 Lint :make <bar> copen
]]
