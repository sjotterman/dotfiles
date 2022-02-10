" .vimrc
" Samuel Otterman

set nocompatible                 " use vim defaults (much better!)
filetype plugin indent on

" Display
syntax on
set termguicolors

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

set background=dark

set list                         " show me the unshowable!
set laststatus=2                 " show statusline even if there is only one window
set helpheight=10                " minimum height of help window when it opens
set hidden                       " so we can more easily change buffers when
                                 " changes, as in earlier versions
set hlsearch                     " Highlights search items
set incsearch                    "  show match as pattern is typed
set nostartofline                " don't change that cursor column!
set number                     " Show line numbering
set ruler                        " show ruler
set scrolloff=5                  " keep at least 5 lines around the cursor
set sidescrolloff=5
set showmatch                    " show matching braces
set showmode                     " show insert/replace/visual message on bottom line
set splitbelow                   " new window goes *below* current window
set splitright                   " Open new vertical windows to the right
set t_Co=256                     " 256 color mode
set wildmenu                    " Enable tab autocompletion of file names
set wildmode=full:longest
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
set wrap                         " wrap long lines
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

" Number of lines of autosuggestions
set pumheight=7

