require("onedarkpro").setup({
  dark_theme = "onedark_vivid"
})
vim.cmd [[
try
    let g:sonokai_style = 'atlantis'
    let g:sonokai_better_performance = 1
    colorscheme sonokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
