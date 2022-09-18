vim.cmd [[
  set background=dark
try
  colorscheme humanoid
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]
