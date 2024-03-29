vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
  " resize all tabs then reopen the one that was open originally
    autocmd VimResized let curr_tab_num = tabpagenr() | * tabdo wincmd = | exe "tabn ".curr_tab_num
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _go
    autocmd!
    autocmd FileType go setlocal nolist
    autocmd BufNewFile,BufRead *.gohtml setfiletype gohtmltmpl
  augroup end

  augroup _term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
  augroup end

" Autoformat

" Disable autoformat for certain projects
" augroup DisabledAutoformat
"     autocmd!
"     autocmd BufNewFile,BufRead ~/workspace/accounts/**/* autocmd! Autoformat
" augroup END

  augroup make_typescript
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]]
