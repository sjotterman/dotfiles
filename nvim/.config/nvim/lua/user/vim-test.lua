-- make test commands execute using dispatch.vim
vim.cmd([[
  let test#strategy = "neovim"
  let test#neovim#term_position = "vert botright 60"
]])
