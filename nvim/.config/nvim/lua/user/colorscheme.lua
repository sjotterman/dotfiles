vim.cmd [[
try
  colorscheme onedarkhc
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
