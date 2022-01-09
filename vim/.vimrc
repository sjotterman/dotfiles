" .vimrc
" Samuel Otterman

set nocompatible                 " use vim defaults (much better!)
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary' " Comment / uncomment code
" Set comment string depending on where in the file you are, so commenting
" works as expected in a JSX / TSX file
Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-unimpaired'
" Work with variants of words. Plurals, change casing
Plug 'tpope/vim-abolish'
Plug 'yuezk/vim-js'
Plug 'peitalin/vim-jsx-typescript'
Plug 'liuchengxu/vim-which-key'
" Start screen / project switcher
Plug 'mhinz/vim-startify'
" Syntax Highlighting for many languages
Plug 'sheerun/vim-polyglot'
Plug 'pantharshit00/vim-prisma'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'itchyny/lightline.vim'
Plug 'gcmt/taboo.vim'
" Color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sainnhe/sonokai'
Plug 'rakr/vim-one'
call plug#end()
filetype plugin indent on

" Display
syntax on
set termguicolors

" Taboo tab name defaults to working directory
let g:taboo_tab_format = " %P "

" Do not use old regex engine. Recommended by yats
set re=0

let g:yats_host_keyword = 1


"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
set guifont=Hack\ Nerd\ Font:h16
if has("gui_running") || has("termguicolors")
  " Left in so I can easily set up different color schemes if desired
  colorscheme onedark
else
  colorscheme sonokai
endif
set background=dark

set list                         " show me the unshowable!
set laststatus=2                 " show statusline even if there is only one window
set helpheight=10                " minimum height of help window when it opens
set hidden                       " so we can more easily change buffers when
                                 " changes, as in earlier versions
set hlsearch                     " Highlights search items
set incsearch                    "  show match as pattern is typed
set nostartofline                " don't change that cursor column!
" set nonumber                     " Hide line numbering
set number                     " Show line numbering
set ruler                        " show ruler
set scrolloff=5                  " keep at least 5 lines around the cursor
set showmatch                    " show matching braces
set showmode                     " show insert/replace/visual message on bottom line
set splitbelow                   " new window goes *below* current window
set splitright                   " Open new vertical windows to the right
set t_Co=256                     " 256 color mode
set wildmenu                    " Enable tab autocompletion of file names
set wildmode=list:longest       " Autocomplete to longest unambiguous string, like BASH
set lazyredraw                  " do not redraw while running macros (much faster)
set autoread                    " automatically reload files updated outside of Vim


" Text editing

set autoindent
set backspace=2                  " allow backspacing over the start of insert
" set cpoptions+=u                 " Pressing u twice undoes the undo
set cindent
set expandtab                    " use spaces, not tab characters!
set formatoptions=ql           " r - autoinsert comment leader with <Enter>
                                " q - allow formatting of comments with :gq
                                " l - don't format already long lines
set ignorecase                   " Ignore case when searching
set listchars=tab:>-,trail:x     " configure listmode
set nojoinspaces                 " i don't want two spaces after a period when joining
set nrformats=hex                " When incrementing numbers, don't treat leading 0's as octal
set pastetoggle=<F2>             " <F2> enables pasting without auto indent
set sidescroll=1                 " when nowrapping, numcolumns to scroll horizontally
set shiftround                   " for > and < commands, round indent to multiple of shiftwidth
set shiftwidth=2                 " numspaces to use for each step of (auto)indent
set smartindent
set tabstop=2                    " tabs at every two columns
set textwidth=80                 " wrap after 80 columns
set wrap                         " don't wrap long lines, i'll scroll if i want to see
set noswapfile                   " Disable swap file
set diffopt=vertical             " Diffs should be displayed vertically
set clipboard=unnamed            " Use system clipboard
set timeout ttimeout             " separate mapping and keycode timeouts
set timeoutlen=1000              " mapping timeout 1000ms  (adjust for preference)
set ttimeoutlen=20               " keycode timeout 20ms
set updatetime=300

" avoid some common typos
cmap WQ wq
cmap Wq wq
cmap W w
cmap Q q

" Easier pane navigation
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
" Same keybindings, but for terminal buffers
tmap <C-j> <C-w>j
tmap <C-k> <C-w>k
tmap <C-h> <C-w>h
tmap <C-l> <C-w>l

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

autocmd BufEnter,BufNewFile,BufReadPost *.md set suffixesadd=.md

"folding settings
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default


" Commands
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis

" Syntax check php files
:autocmd FileType php noremap <F7> :w ! php -l<CR>

" Spell check for md and text files files
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us


" Everything else
set mousetime=500                " maximum multiclick delay
" Enable mouse in terminal
" Prevent highlighting line numbers, and can drag window borders
set mouse=a

" set backup                       " keep a backup file
set backupdir=$TEMP,$TMP,.       " use one of these directories for the backupfile
" set directory=$TEMP,$TMP,.       " use one of these directories for the swapfile

filetype off                              " Need to bounce filetypes
let myfiletypefile = "$VIM/myftypes.vim"  " ...to make my filetypes
filetype on                               " ...effective!

filetype plugin on               " Load custom filetype settings

let mysyntaxfile = "$VIM/mysyntax.vim"

autocmd BufEnter,BufNewFile,BufReadPost * set textwidth=0 | set nocindent
autocmd BufEnter,BufNewFile,BufReadPost *.md set suffixesadd=.md

autocmd BufEnter,BufNewFile,BufReadPost *.txt set textwidth=80
autocmd BufEnter,BufNewFile,BufReadPost *.txt set nonumber
autocmd BufEnter,BufNewFile,BufReadPost *.txt,*.md set nonumber

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") < line("$") |
  \   exe "normal! g`\"" |
  \ endif


" Be sure expandtab is off for makefiles
autocmd FileType make set noexpandtab

auto BufEnter * let &titlestring = strftime("%j  %H:%M  ") . "%F"

" associate *.buf with sql filetype (for launching VIM from SQLPLUS)
au Bufread,BufNewFile *.buf setfiletype sql


" Auto reload .vimrc on making changes
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost ~/.vimrc nested source % | echom "Reloaded ~/.vimrc"  | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" plugin settings

" Prettier command
" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Run prettier only if config file
let g:prettier#autoformat_config_present = 1

" NerdTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^node_modules$']

" Close vim if NERDTree is only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Show hidden files in nerdtree
let NERDTreeShowHidden=1

" Lightline - status line replacement

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \            [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filetype': 'LightlineFiletype',
      \  'cocstatus' : 'coc#status'
      \ },
      \ }
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


" COC.nvim - Language Server / Code completion
" I might re-add this
  " \ 'coc-tslint-plugin',
  " \ 'coc-snippets',
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-tslint-plugin',
  \ 'coc-css',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" Auto close fugitive buffers that weren't closed correctly
autocmd BufReadPost fugitive://* set bufhidden=delete

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" let g:coc_snippet_next = '<tab>'

" press CTRL + space to trigger autocomplete while in insert mode
inoremap <silent><expr><C-Space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap  gt :tabs

nmap ]g <Plug>(coc-diagnostic-next)
nmap [g <Plug>(coc-diagnostic-prev)
command! ListAllTabs :tabs

" Number of lines of autosuggestions
set pumheight=7

nnoremap <silent>gh :call CocActionAsync('doHover')<CR>


let g:startify_bookmarks = [ {'v': '~/.vimrc'},
      \ {'z': '~/.zshrc'},
      \'~/.vim/plugin/which-key.vim']
let g:startify_lists = [
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ { 'header': ['   Bookmarks'],       'type': 'bookmarks' },
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ ]
" " Update session automatically as you exit vim
let g:startify_session_persistence = 1
let g:startify_custom_header = [
 \ '      ',
 \ '             _         ',
 \ '      _   __(_)___ ___ ',
 \ '     | | / / / __ `__ \',
 \ '     | |/ / / / / / / /',
 \ '     |___/_/_/ /_/ /_/ ',
 \ '                         ',
 \ '        ',
 \]
" autocmd User Startified %foldopen!
"

" Copy FZF results to the quick fix list by pressing CTRL+A, CTRL+Q
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" When using Ag, ignore file names that contain the search string
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
