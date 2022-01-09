let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
tabnew
tabnew
tabrewind
edit workspace/shipyard/apps/create-api/src/app/screens/screens.service.ts
argglobal
balt workspace/shipyard/apps/create-api/src/app/core/prisma/mysql.service.ts
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 9 - ((8 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 9
normal! 03|
lcd ~/workspace/shipyard
if exists(':tcd') == 2 | tcd ~/workspace/shipyard | endif
tabnext
edit ~/workspace/accounts/server/models/account.json
argglobal
balt ~/workspace/accounts/server/models/account.js
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 24 - ((23 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 24
normal! 017|
lcd ~/workspace/accounts
if exists(':tcd') == 2 | tcd ~/workspace/accounts | endif
tabnext
edit ~/.config/nvim/lua/user/colorscheme.lua
argglobal
balt ~/.config/nvim/lua/user/colorscheme.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 5 - ((4 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 0
lcd ~/.config/nvim
if exists(':tcd') == 2 | tcd ~/.config/nvim | endif
tabnext 1
badd +1 ~/workspace/accounts/server/models/account.json
badd +0 ~/.config/nvim/lua/user/colorscheme.lua
badd +9 ~/workspace/shipyard/apps/create-api/src/app/screens/screens.service.ts
badd +18 ~/workspace/shipyard/apps/create-api/src/app/core/prisma/mysql.service.ts
badd +0 ~/workspace/accounts/server/config.development.js
badd +276 ~/workspace/accounts/server/models/account.js
badd +31 ~/workspace/flagship.api/src/properties/properties.controller.ts
badd +1 ~/workspace/noahsark/src/screens/CreateAccount.tsx
badd +1 ~/workspace/noahsark/src/store/flashMsg/reducer.ts
badd +225 ~/.config/lvim/config.lua
badd +21 ~/.config/nvim/init.lua
badd +87 ~/.config/nvim/lua/user/plugins.lua
badd +1 ~/.config/nvim/lua/user/lsp/null-ls.lua
badd +7 ~/.config/nvim/lua/user/lsp/init.lua
badd +1 ~/workspace/noahsark/src/lib/authentication.ts
badd +1 ~/workspace/noahsark/src/screens/SetPasswordScreen.tsx
badd +1 ~/workspace/noahsark/src/screens.tsx
badd +7 ~/workspace/noahsark/src/screens/Flows.tsx
badd +137 ~/workspace/noahsark/src/components/SetPassword.tsx
badd +196 ~/workspace/noahsark/src/store/account/action.ts
badd +176 ~/workspace/noahsark/src/containers/AuthenticatedContainer.tsx
badd +14 ~/workspace/noahsark/src/containers/SetPasswordContainer.tsx
badd +1 ~/workspace/noahsark/src/screens/Preview.tsx
badd +105 ~/workspace/noahsark/src/components/SignIn.tsx
badd +177 ~/workspace/shipyard/README.md
badd +17 ~/workspace/shipyard/.prettierrc
badd +18 ~/workspace/shipyard/package.json
badd +15 ~/workspace/shipyard/apps/create-api/.env.example
badd +19 ~/workspace/shipyard/apps/create-api/.env
badd +39 ~/workspace/flagship.api/.env
badd +3 ~/workspace/shipyard/apps/create-api/.eslintrc.json
badd +10 ~/workspace/shipyard/apps/create-api/src/app/component-instances/component-instances.module.ts
badd +22 ~/workspace/shipyard/apps/create/README.md
badd +65 ~/.config/nvim/lua/user/toggleterm.lua
badd +20 ~/workspace/shipyard/apps/create/src/app/SetPassword.tsx
badd +26 ~/.zshrc
badd +71 ~/workspace/shipyard/apps/create/src/app/lib/authentication.ts
badd +676 ~/workspace/shipyard/apps/create/src/app/lib/appBuilderService.ts
badd +1144 ~/workspace/noahsark/src/lib/appBuilderService.ts
badd +26 ~/workspace/shipyard/apps/create/src/app/lib/apiFormatter.ts
badd +14 ~/workspace/shipyard/apps/create/src/components.json
badd +165 ~/workspace/jwt-issuer/src/login.ts
badd +27 ~/workspace/shipyard/apps/create-api/src/app/properties/properties.controller.ts
badd +39 ~/workspace/shipyard/apps/create-api/src/app/properties/properties.service.ts
badd +10 ~/.config/nvim/lua/user/options.lua
badd +104 ~/.config/nvim/lua/user/lsp/handlers.lua
badd +1 ~/.config/nvim/lua/user/lsp/lsp-installer.lua
badd +25 ~/.config/nvim/lua/user/autocommands.lua
badd +10 ~/workspace/accounts/server/datasources.json
badd +5 ~/workspace/accounts/public_key_DEV.pem
badd +39 ~/workspace/shipyard/CONTRIBUTING.md
badd +13 ~/workspace/shipyard/commitlint.config.js
badd +36 ~/workspace/shipyard/nx.json
badd +2 ~/workspace/shipyard/apps/create/src/app/components/formElements/PasswordInput.tsx
badd +23 ~/workspace/shipyard/apps/create/src/app/components/SetPassword.tsx
badd +17 ~/workspace/shipyard/apps/create/src/app/containers/SetPasswordContainer.tsx
badd +4 ~/workspace/shipyard/apps/create/src/app/screens/SetPasswordScreen.tsx
badd +252 ~/workspace/shipyard/apps/create/src/app/lib/apiTypes.ts
badd +207 ~/workspace/shipyard/apps/create/src/app/lib/translations/en.ts
badd +8 ~/workspace/shipyard/apps/create/src/app/lib/translations/types.ts
badd +1 ~/workspace/shipyard/apps/create/src/app/screens.tsx
badd +183 ~/workspace/shipyard/apps/create/src/app/store/account/action.ts
badd +181 ~/workspace/shipyard/apps/create/src/app/containers/AuthenticatedContainer.tsx
badd +30 ~/.config/nvim/lua/user/whichkey.lua
badd +16 ~/workspace/shipyard/apps/create-api/src/main.ts
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=tfcoilxTOnF
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
