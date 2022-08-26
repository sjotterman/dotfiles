require("onedarkpro").setup({
  dark_theme = "onedark_vivid"
})
vim.cmd [[
try
   colorscheme onedarkpro
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
